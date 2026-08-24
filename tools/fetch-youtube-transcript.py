#!/usr/bin/env python3
"""Fetch a YouTube transcript from a network that SNI-blocks www.youtube.com.

Use `yt-dlp` first -- it is simpler and works on any unfiltered network. Reach for
this only when yt-dlp cannot connect (see memory feedback_yt_dlp_transcripts).

WHY THIS EXISTS -- three independent walls, each needing a different trick:

1. TRANSPORT. A middlebox blocks www.youtube.com by SNI, but only on TLS-over-TCP.
   QUIC (UDP/443) sails through, so Chrome is launched with --enable-quic and
   --origin-to-force-quic-on. yt-dlp cannot do this: it has NO HTTP/3 backend
   (urllib / requests / curl_cffi / websockets are all TCP). No version fixes that.

2. POT. Caption URLs need a proof-of-origin token we cannot mint -- it comes from
   YouTube's own JS. So we don't mint one: we let the real player request its
   captions and capture the URL it used, via CDP Network events.

3. HEADLESS DETECTION. This is the subtle one. Chrome's UA leaks into the caption
   request as `cbr=HeadlessChrome`, and YouTube then answers with an empty 200 --
   no error, no failure, just zero bytes. Overriding the User-Agent so `cbr=Chrome`
   is what actually makes captions arrive. Symptom to recognise: a timedtext
   request that finishes successfully with a 0-byte body.

Also handles pre-roll ads: an ad is a different video with its own (short) duration,
and asking for captions during one yields an empty response for the ad.

Usage:  py -3 tools/fetch-youtube-transcript.py <video_id_or_url> [out_path]
Requires: websocket-client  (py -3 -m pip install --user websocket-client)
"""
import json, os, re, shutil, subprocess, sys, tempfile, time, urllib.request

try:
    import websocket  # websocket-client
except ImportError:
    sys.exit("need websocket-client:  py -3 -m pip install --user websocket-client")

CHROME = r"C:\Program Files\Google\Chrome\Application\chrome.exe"
PORT = 9333
UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36")


def video_id(s):
    m = re.search(r"(?:v=|youtu\.be/|/shorts/)([A-Za-z0-9_-]{11})", s)
    return m.group(1) if m else s


def kill_tree(pid):
    """Chrome spawns children; terminating the launcher leaves them running.

    Observed 2026-08-24: 22 orphaned processes accumulated across a debugging
    session and kept playing video AUDIBLY, in windows the user could not see or
    close. Always kill the whole tree.
    """
    subprocess.run(["taskkill", "/PID", str(pid), "/T", "/F"],
                   stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)


def fetch(vid, out_path):
    # Fresh profile per run, removed afterwards -- no cookie/state accumulation
    # in an invisible browser.
    profile = tempfile.mkdtemp(prefix="yt-cdp-")
    proc = subprocess.Popen(
        [CHROME, "--headless=new", "--disable-gpu", "--no-first-run",
         "--mute-audio",  # belt-and-braces: JS muting loses races with ads
         f"--remote-debugging-port={PORT}", f"--user-data-dir={profile}",
         "--enable-quic", "--origin-to-force-quic-on=www.youtube.com:443",
         "--autoplay-policy=no-user-gesture-required",
         "--window-size=1400,1000", "about:blank"],
        stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    print(f"[headless chrome pid={proc.pid} profile={profile}]")
    try:
        for _ in range(60):
            try:
                urllib.request.urlopen(f"http://127.0.0.1:{PORT}/json/version", timeout=2)
                break
            except Exception:
                time.sleep(0.5)
        else:
            sys.exit("chrome did not expose CDP")

        targets = json.load(urllib.request.urlopen(f"http://127.0.0.1:{PORT}/json/list"))
        pages = [t for t in targets if t.get("type") == "page" and t.get("webSocketDebuggerUrl")]
        if not pages:
            sys.exit("no CDP page target")
        ws = websocket.create_connection(pages[0]["webSocketDebuggerUrl"], timeout=90,
                                         suppress_origin=True, max_size=100 * 1024 * 1024)

        _id, caps, finished = [0], [], set()

        def send(method, **params):
            _id[0] += 1
            mid = _id[0]
            ws.send(json.dumps({"id": mid, "method": method, "params": params}))
            while True:
                m = json.loads(ws.recv())
                meth = m.get("method")
                if meth == "Network.requestWillBeSent":
                    u = m["params"]["request"]["url"]
                    if "/api/timedtext" in u and "pot=" in u:
                        caps.append((m["params"]["requestId"], u))
                elif meth == "Network.loadingFinished":
                    finished.add(m["params"]["requestId"])
                if m.get("id") == mid:
                    return m.get("result", m.get("error"))

        def ev(expr):
            r = send("Runtime.evaluate", expression=expr, awaitPromise=True, returnByValue=True)
            return (r or {}).get("result", {}).get("value")

        send("Page.enable"); send("Network.enable"); send("Runtime.enable")
        send("Network.setUserAgentOverride", userAgent=UA, platform="Win32")  # wall 3
        send("Page.navigate", url=f"https://www.youtube.com/watch?v={vid}&hl=en")
        time.sleep(8)

        ev("const v=document.querySelector('video'); if(v){v.muted=true; v.play();} 1")
        for _ in range(30):  # sit through any pre-roll
            st = ev("(()=>{const v=document.querySelector('video');"
                    "return {ad:!!document.querySelector('.ad-showing'),dur:v?v.duration:0};})()") or {}
            if not st.get("ad") and (st.get("dur") or 0) > 60:
                break
            ev("document.querySelector('.ytp-ad-skip-button')?.click(); 1")
            time.sleep(1)

        ev("document.querySelector('.ytp-subtitles-button')?.click(); 1")  # wall 2
        for _ in range(25):
            time.sleep(1)
            send("Runtime.evaluate", expression="1", returnByValue=True)
            if any(r in finished for r, _ in caps):
                break
        ev("document.querySelector('video')?.pause(); 1")

        if not caps:
            sys.exit("no POT-bearing timedtext request seen -- does this video have captions?")

        events, seen = [], set()
        for rid, _u in caps:
            body = (send("Network.getResponseBody", requestId=rid) or {}).get("body", "")
            if not body.lstrip().startswith("{"):
                continue
            for e in json.loads(body).get("events", []):
                if not e.get("segs"):
                    continue
                t = e.get("tStartMs", 0)
                if t in seen:
                    continue
                seen.add(t)
                events.append(e)
        ws.close()
        for _rid, u in caps:
            print(f"[fetched] {u[:110]}...")
    finally:
        kill_tree(proc.pid)
        shutil.rmtree(profile, ignore_errors=True)
        print("[headless chrome closed, profile removed]")

    if not events:
        sys.exit("captured requests but no caption events -- if bodies were 0 bytes, "
                 "check the User-Agent override (see module docstring, wall 3)")

    lines = []
    for e in sorted(events, key=lambda x: x.get("tStartMs", 0)):
        t = e.get("tStartMs", 0)
        txt = "".join(s.get("utf8", "") for s in e["segs"]).replace("\n", " ").strip()
        if txt:
            lines.append(f"[{t//60000}:{t//1000%60:02d}] {txt}")
    with open(out_path, "w", encoding="utf-8") as f:
        f.write("\n".join(lines) + "\n")
    print(f"saved {out_path}: {len(lines)} cues, last at {lines[-1].split(']')[0][1:]}")


if __name__ == "__main__":
    if len(sys.argv) < 2:
        sys.exit(__doc__)
    v = video_id(sys.argv[1])
    fetch(v, sys.argv[2] if len(sys.argv) > 2 else f"{v}.transcript.txt")

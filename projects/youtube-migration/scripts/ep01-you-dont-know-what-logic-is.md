# Episode 1: You Don't Know What Logic Is
> Script for the first episode of the Logic series

**Target length:** 14-16 minutes
**Vault source:** [Aristotelian Logic](../../../research/philosophy/logic-and-math/aristotelian-logic.md)
**Style:** Veritasium hook (start with what people think they know, reveal they're wrong) + 3B1B visuals (build intuitions through animation)

## Visual System

Three production layers used throughout the series:

| Layer | What | Tool | When |
|-------|------|------|------|
| **CUTOUT** | Flat cartoon characters (Terrance & Phillip style) for historical figures — Sophists, Socrates, Aristotle, Heraclitus, etc. | AI-generated parts + editor lip-sync, or Adobe Character Animator | Historical scenes, dialogue, personality |
| **MANIM** | Mathematical/logical content — syllogisms, truth tables, diagrams, abstract structures, timelines | Manim (Python) | Logical content, the "3B1B moments" |
| **HOST** | Chris talking to camera or voiceover | Camera + mic | Direct address, personality, sign-off |

Visual tags in the script: `[CUTOUT]` `[MANIM]` `[HOST]` `[TEXT]`

### Character Assets Needed (Episode 1)

| Character | Design notes | Reuse |
|-----------|-------------|-------|
| **Generic Sophist** | Slick-looking, gesturing confidently, maybe a money pouch | Ep 1 only (or background cameos) |
| **Socrates** | Stocky, balding, perpetually questioning expression | Recurring (Ep 1, maybe Ep 4) |
| **Aristotle** | Dignified but approachable, holds a scroll/book | Recurring (Ep 1-3, cameos throughout) |
| **Heraclitus** | Wild-haired, slightly unhinged, pointing at a river | Ep 1 only |
| **Generic Athenians** | 2-3 background characters for agora scenes | Ep 1 background |
| **Frustrated debater** | Modern clothes, for the non-contradiction dialogue scene | Ep 1, maybe recurring |

Mouth positions needed per character: closed, open-small, open-wide, smile. Four frames per character is sufficient for Terrance & Phillip style lip-sync.

---

## COLD OPEN [0:00 – 0:40]

**[TEXT] Black screen. Text appears one word at a time, white on black.**

> "That's not logical."

**[Beat.]**

> "Your argument is contradictory."

**[Beat.]**

> "You're being irrational."

**[HOST] Voiceover (or talking head, either works here):**
You've heard these phrases a thousand times. In debates, in arguments, on the internet. People throw around the word "logic" like it's a weapon — like it's this obvious, settled thing that everyone agrees on and their opponent is just too stupid to see.

**[CUTOUT] Quick sequence: Two cartoon modern figures arguing. Speech bubbles appear with the phrases above. Both look confident. Neither is actually making a logical argument.**

But here's the thing. When someone says "that's not logical" — what do they actually mean? What IS logic? Where did it come from? And — here's the part that's going to surprise you — is it even ONE thing?

**[MANIM] Title card animates in — "You Don't Know What Logic Is" — clean typography, maybe the letters rearrange from the phrases above.**

---

## ACT 1: BEFORE ARISTOTLE [0:40 – 3:00]

**[CUTOUT] Wide shot: A simple cartoon agora — columns, blue sky, a few background Athenians milling around. Flat, colorful, distinctively "ours."]**

**[HOST] Voiceover:**
The year is roughly 400 BC. Athens is the intellectual center of the Western world. And everyone is arguing.

**[CUTOUT] The Sophist character steps into frame. Confident posture, gesturing broadly. A coin purse jingles at his belt.]**

The Sophists are teaching people how to win arguments — not how to find truth, but how to persuade. How to make the weaker argument appear stronger. They're basically the debate coaches of the ancient world, and they're making good money at it.

**[CUTOUT] Sophist's speech bubble fills with fancy-looking words that are actually nonsense — squiggles that LOOK impressive. An Athenian hands him coins, nodding along.]**

**[CUTOUT] Socrates enters from the other side. Stocky, bald, perpetual squint. He looks at the Sophist.]**

Socrates pushes back. He asks questions — endless questions — until his opponents contradict themselves. He's not proving anything. He's just poking holes. It works, but it's messy.

**[CUTOUT] Socrates: "But what do you MEAN by justice?" Sophist looks annoyed. Socrates: "And what do you mean by MEAN?" Sophist's eye twitches. Socrates: "Define 'define.'" Sophist storms off.]**

**[HOST] Voiceover (continuing over the cutout scene):**
Plato writes dialogues — conversations where characters work through problems together. Beautiful literature. But no formal rules.

Here's the thing everyone is missing: nobody has written down the RULES. Everyone is reasoning — arguing, deducing, concluding — but nobody has asked the question: what makes a valid argument valid? Not persuasive. Not emotionally compelling. VALID. Structurally, formally, mechanically correct.

**[MANIM] Simple animation: A bridge being built — geometric beams appearing one by one. Some configurations hold (green check). Some collapse (red X). No formula visible — just trial and error.]**

That's like building a bridge without engineering. People were building bridges before physics existed — some stood up, some collapsed. But nobody had the math to tell you IN ADVANCE which ones would hold.

Logic is the engineering of arguments. And one person invented it.

---

## ACT 2: THE INSIGHT [3:00 – 6:00]

**[CUTOUT] Aristotle enters. Dignified, carrying a scroll. He looks at the mess Socrates left behind, shakes his head slightly, unrolls his scroll.]**

**[HOST] Voiceover:**
Aristotle. Around 350 BC. Student of Plato, tutor to Alexander the Great, and — I'm going to argue — responsible for the single most important intellectual achievement in human history.

**[Beat for emphasis.]**

Here's what he did.

**[MANIM] The classic syllogism builds line by line. Clean text, each line appearing with a soft animation:]**

```
All men are mortal.
Socrates is a man.
Therefore, Socrates is mortal.
```

**[HOST] Voiceover:**
You've seen this before. It's in every intro philosophy textbook. It looks obvious. But watch what happens when I do THIS.

**[MANIM] The words fade to ghost-gray. Then letters replace the content — A, B, C sliding in where the words were, color-coded:]**

```
All A are B.
C is A.
Therefore, C is B.
```

**[MANIM] The structure pulses. Then a new set of words flows in from the left, filling the structure like liquid pouring into a mold:]**

```
All dogs are mammals.        All A are B.
Rex is a dog.                C is A.
Therefore, Rex is a mammal.  Therefore, C is B.
```

**[MANIM] Another set flows in, replacing the first:]**

```
All prime numbers are integers.  All A are B.
7 is a prime number.             C is A.
Therefore, 7 is an integer.      Therefore, C is B.
```

**[HOST] Voiceover:**
See what happened? The argument works regardless of what you plug in. Dogs, numbers, people — doesn't matter. The STRUCTURE is what makes it valid. Not the content. Not whether you agree with the premises. The shape of the argument.

**[MANIM] The structure lifts away from the examples and floats free — rotating slowly, an abstract geometric form. The specific words are gone. Only the A/B/C skeleton remains. It glows. This is the "3B1B moment" — the abstraction made visible.]**

**[HOST] Voiceover:**
Aristotle separated the FORM of an argument from its CONTENT. And that separation — that abstraction — is the move that makes everything else possible. Boolean algebra. Computer programming. Mathematical proof. Artificial intelligence. All of it descends from this one insight: the structure of reasoning can be studied independently of what you're reasoning about.

**[MANIM] Timeline appears horizontally. Aristotle on the left (with small cutout portrait). Dates and names appear rightward: Boole (1854), Frege (1879), Turing (1936), modern circuit board icon. The abstract A/B/C structure floats above the timeline, connecting all of them.]**

**[HOST] Voiceover:**
And here's a detail most people miss. Aristotle called his logical works the "Organon."

**[CUTOUT] Aristotle holds up his scroll. Text on it reads: "ORGANON" with a subtitle appearing: "(Greek: tool)"]**

That's Greek for "tool" or "instrument." He didn't think of logic as a cosmic law inscribed in the fabric of reality. He thought of it as a TOOL. Something humans built to reason correctly. Remember that. It's going to matter later in this series.

---

## ACT 3: THE THREE LAWS [6:00 – 10:30]

**[HOST] Voiceover:**
Aristotle identified three principles he considered foundational. These are the laws that most people mean when they say "logic." And to be fair, they're pretty good.

### Law 1: Identity [6:00 – 7:30]

**[MANIM] A rock appears on screen. Clean, solid, definite. A blue glow around it — identity = blue throughout the series.]**

**[HOST] Voiceover:**
Law one. The Law of Identity. A is A. A thing is what it is.

**[MANIM] Text appears with blue accent — "A = A"]**

Sounds obvious, right? A rock is a rock. The number 7 is 7. Tuesday is Tuesday.

But here's why it matters. About 150 years before Aristotle, a philosopher named Heraclitus made a disturbing observation.

**[CUTOUT] Heraclitus appears — wild hair, slightly manic expression. He's standing next to a flowing river. He points at it emphatically.]**

He said: you can never step in the same river twice. The water is different. The banks are eroding. The fish have moved. Everything is in flux. EVERYTHING. If nothing is stable, nothing has a fixed identity. And if nothing has a fixed identity...

**[MANIM] The rock from before starts flickering, its edges dissolving into particles, becoming uncertain.]**

...you can't say anything definite about anything. Logic collapses before it starts.

**[MANIM] The rock snaps back into focus. Solid. Blue glow restored.]**

**[HOST] Voiceover:**
Aristotle's response: at any given moment, in any given respect, a thing IS itself. The river is THIS river RIGHT NOW. It might be different tomorrow. But right now, A is A.

**[MANIM] Text appears below the rock, highlighting as spoken: "at the same time" pulses, "and in the same respect" pulses.]**

Remember those qualifiers. They're doing a LOT of work. And 2,400 years later, quantum physics is going to challenge them. But we'll get to that.

### Law 2: Non-Contradiction [7:30 – 9:00]

**[MANIM] A ball appears. Bright red. Red glow — non-contradiction = red throughout the series.]**

**[HOST] Voiceover:**
Law two. The Law of Non-Contradiction. A thing cannot be both B and not-B at the same time and in the same respect.

**[MANIM] Text with red accent — "P and ¬P cannot both be true"]**

This ball cannot be entirely red AND entirely not-red simultaneously.

**[MANIM] The ball tries to be red and blue at the same time — it flickers, glitches, visual static. It looks WRONG. The animation itself rejects it.]**

You cannot be in Denver AND not in Denver right now. The statement "it is raining" cannot be both true and false at this moment in this location.

Now, this is the law that does the MOST work in arguments. When someone says "your view is contradictory," they're invoking this law. And most of the time, they're right to. Contradictions usually mean someone made an error.

**[MANIM] The ball settles on red. Clean, definite.]**

But — and this is important — watch those qualifiers again. "At the same time AND in the same respect."

**[MANIM] The ball smoothly transitions: red on top, blue on bottom. Clean, no glitch. This one is FINE.]**

This ball IS red and not-red. But in DIFFERENT respects — red on top, blue on bottom. That's not a contradiction. Most alleged contradictions in arguments dissolve when you ask: "are we talking about the same thing in the same way?"

**[CUTOUT] Two modern cartoon figures arguing. Speech bubbles show the same word ("freedom") but with different definitions floating inside each bubble. A label appears between them: "This isn't a logic error. It's a translation error."]**

**[HOST] Voiceover:**
We'll come back to that in episode 3.

### Law 3: Excluded Middle [9:00 – 10:30]

**[MANIM] A light switch appears. ON or OFF. Green glow — excluded middle = green throughout the series.]**

**[HOST] Voiceover:**
Law three. The Law of Excluded Middle. For any proposition, either it's true or it's false. There is no third option.

**[MANIM] Text with green accent — "P or ¬P. Always."]**

Either it's raining or it isn't. Either 7 is prime or it isn't. Either Caesar crossed the Rubicon or he didn't.

This seems bulletproof. And for 2,300 years, nobody seriously challenged it.

**[MANIM] The light switch starts to flicker uncertainly.]**

But think about this. "Is that person tall?"

**[CUTOUT] A cartoon lineup of five people at different heights: 5'2", 5'6", 5'10", 6'0", 6'4". Height labels above each.]**

**[MANIM] A red line tries to draw a sharp horizontal boundary between "TALL" and "NOT TALL." It slides up and down, unable to find a natural place to land. The line itself looks uncertain.]**

**[HOST] Voiceover:**
Where's the line? The excluded middle says there MUST be a sharp boundary. You're either tall or not tall. But reality doesn't have a sharp boundary here. It's a gradient.

**[MANIM] The light switch morphs into a dimmer — a continuous slider. It slides smoothly from off to full brightness, passing through every value in between.]**

In 1965, a mathematician named Lotfi Zadeh asked: what if truth isn't a switch? What if it's a dimmer? And he built an entire logical system around that idea. It's called fuzzy logic. And your washing machine probably runs on it.

**[MANIM] The three laws appear stacked, each in its color (blue, red, green), clean and solid. Then subtle hairline cracks appear in each one. Not breaking — just showing they're not as invincible as they seem. The cracks glow faintly.]**

---

## ACT 4: WHAT ARISTOTLE MISSED [10:30 – 13:00]

**[HOST] Voiceover:**
Now, Aristotle's system is extraordinary. It dominated for over two thousand years. But it has blind spots.

### Relations [10:30 – 11:15]

**[CUTOUT] Two cartoon figures standing side by side. One is clearly taller. They look at each other.]**

**[HOST] Voiceover:**
"Alice is taller than Bob." Simple statement. Can't express it in Aristotle's logic. His system handles properties — "all A are B" — but not RELATIONS between things. You can say "Alice is tall" and "Bob is short," but you can't formally capture "taller THAN."

**[MANIM] The syllogism structure from Act 2 reappears. The phrase "taller than" tries to fit into the All-A-are-B slots. It doesn't fit — the structure distorts, the text bounces off. Like the wrong puzzle piece.]**

**[HOST] Voiceover:**
This seems minor until you realize that MOST of what science talks about is relations. Force equals mass TIMES acceleration. Energy equals mass times the speed of light SQUARED. These are relationships between quantities. Aristotle's logic can't touch them.

It took until 1879 — over 2,200 years — for a mathematician named Gottlob Frege to fix this. We'll cover that in episode 2.

### Self-Reference [11:15 – 12:00]

**[MANIM] Black screen. A sentence appears letter by letter, typewriter-style:]**

> "This sentence is false."

**[Beat. Two full seconds of silence.]**

**[HOST] Voiceover:**
Is it true? If it's true, then what it says is correct — it's false. But if it's false, then what it says is wrong — so it's true.

**[MANIM] The sentence curves into a circle, the end connecting to the beginning. It spins — an impossible loop. Escher-style impossible staircase appears behind it, the sentence spiraling along the stairs.]**

**[HOST] Voiceover:**
This is the liar paradox. It's been known since ancient Greece. Aristotle knew about it. He didn't solve it. Nobody has — not cleanly. It drove the development of entire branches of logic in the 20th century. And in 1931, a 25-year-old mathematician named Kurt Gödel weaponized it to prove that logic itself has fundamental, inescapable limits.

**[CUTOUT] Brief flash: A young cartoon Gödel, glasses, slight smile, holding a short paper. Text overlay: "26 pages." He looks polite. Devastatingly polite.]**

That's episode 4. And it's going to break your brain.

### The Punchline [12:00 – 13:00]

**[MANIM] The three laws appear center screen, stacked neatly in their colors (blue, red, green), with their hairline cracks. They look like a small island.]**

**[MANIM] The camera slowly pulls back. As it does, other logical systems appear around the island — each a different colored shape with a label:]**

- Intuitionistic Logic (drops excluded middle)
- Paraconsistent Logic (tolerates contradictions)
- Fuzzy Logic (truth in degrees)
- Quantum Logic (nature rewrites the rules)
- Nagarjuna's Catuskoti (4-valued, c. 150 AD)
- Jain Syadvada (7-valued, c. 500 BC)

**[The pullback continues until Aristotle's three laws are a small cluster in a vast, colorful landscape of alternatives.]**

**[HOST] Voiceover:**
Here's what most people don't know. Aristotle's three laws aren't THE laws of logic. They're the FIRST laws. The starting point. In the 2,400 years since Aristotle, mathematicians and philosophers have built dozens of alternative logical systems — some that DROP one of these laws and still work perfectly. Some that were demanded by physics itself, because nature doesn't obey the rules Aristotle wrote down.

Logic isn't a single, settled, finished system. It's a 2,400-year research program that's still running. The three laws are the first draft. An extraordinary first draft — maybe the most important intellectual achievement in human history. But a first draft.

And if THAT surprises you, wait until you see what happened when we tried to make logic PERFECT.

---

## OUTRO [13:00 – 14:00]

**[TEXT] Clean white text on dark background:**

> "Next time: logic becomes math, math becomes computers, and a dream that took 250 years to build gets destroyed in 26 pages."

**[MANIM] Quick preview sequence: Boolean algebra equations animating, a circuit board lighting up, the Principia Mathematica page, then a red X slamming across it all.]**

**[HOST] Talking head (first time on camera in the episode — the reveal):**
This is episode 1 of a series on the history of logic — what it is, where it came from, why it matters, and where it breaks. If you want to understand why people argue past each other, why AI can't think, and why the deepest questions in philosophy are still open — this is the foundation.

I'm Chris. I'll see you in episode 2.

**[TEXT] Subscribe prompt. End card with episode 2 link.]**

---

## PRODUCTION NOTES

### Character Production Pipeline
1. **Design:** AI-generate each character in a consistent flat/cutout art style. Prompt for: "flat 2D cutout animation style, simple shapes, bold colors, [character description]"
2. **Part separation:** Separate head, body, arms into layers (Photoshop, GIMP, or even Canva)
3. **Mouth variants:** Generate or draw 4 mouth positions per character (closed, small-open, wide-open, smile)
4. **Animation:** In editor (DaVinci Resolve), swap mouth layers on beat with voiceover. OR: use Adobe Character Animator for auto lip-sync from audio
5. **Reuse:** Save all character assets in a `/characters/` folder. Aristotle, Socrates, and Gödel recur across the series

### Manim Animation List (in order of appearance)
1. Title card text animation
2. Bridge building — geometric beams, green checks / red X's
3. Syllogism building line by line
4. Words fading → A/B/C structure replacing → examples flowing through
5. Abstract structure floating free (the "3B1B moment")
6. Timeline: Aristotle → Boole → Frege → Turing → modern
7. Rock appearing / dissolving / snapping back (identity)
8. "At the same time and in the same respect" text pulse
9. Red ball / glitch / split-color (non-contradiction)
10. Light switch → dimmer morph (excluded middle)
11. Height lineup with sliding red boundary line
12. Three laws stacked with hairline cracks
13. Syllogism structure rejecting "taller than"
14. Liar paradox sentence → impossible loop
15. The landscape pullback (three laws island → ocean of alternatives)
16. Preview sequence for episode 2

### Color Code (maintained throughout series)
- **Identity:** Blue
- **Non-Contradiction:** Red
- **Excluded Middle:** Green
- **Classical logic overall:** White/light gray
- **Non-classical alternatives:** Each gets a unique color (assign in Ep 5-7)

### Audio Notes
- Music: Ambient/minimal underneath narration. Build during key reveals (the abstraction moment, the landscape pullback). Something like Kurzgesagt's scoring — present but not distracting.
- Sound design: Subtle sound effects for the Manim animations (whoosh for text appearing, click for the light switch, static for the non-contradiction glitch). Adds polish without much effort.

### Shooting Notes
- HOST segments can be minimal for Episode 1 — mostly voiceover. Save the talking-head reveal for the outro (makes it a moment).
- If doing voiceover-only: record in a quiet room, USB condenser mic ($50-100), free Audacity for editing.
- If doing talking head: simple backdrop (bookshelf, plain wall), ring light, phone camera or webcam is fine for v1.

### Estimated Production Time (novice)
| Task | Time estimate |
|------|--------------|
| Character design (AI + cleanup) | 4-6 hours first time, faster after |
| Manim animations (16 items) | 10-15 hours (learning curve heavy on first episode) |
| Voiceover recording | 2-3 hours (multiple takes) |
| Video editing (assembly + timing) | 6-8 hours |
| Music/sound | 2-3 hours |
| **Total Episode 1** | **~25-35 hours** |
| **Subsequent episodes** | **~15-20 hours** (assets reusable, Manim skills improve) |

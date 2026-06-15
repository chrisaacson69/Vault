const path = require("path");

module.exports = function(eleventyConfig) {

  // Resolve relative .md links in rendered HTML to the correct pretty URL.
  // Obsidian links are relative to the SOURCE file; pretty URLs shift each page
  // down one dir, so we resolve against the source dir then emit an absolute
  // (pathPrefix-aware) URL. README.md -> the dir's index; foo.md -> foo/.
  eleventyConfig.addTransform("resolveMdLinks", function(content) {
    if (!(this.page.outputPath || "").endsWith(".html")) return content;
    const inp = (this.page.inputPath || "").replace(/^\.\//, "").replace(/\\/g, "/");
    const srcDir = inp.split("/").slice(0, -1).join("/");
    const prefix = (process.env.PATH_PREFIX || "/").replace(/\/+$/, ""); // "" or "/Vault"
    return content.replace(/href="([^"]+?\.md)(#[^"]*)?"/g, (m, link, hash) => {
      if (/^(https?:|\/\/|\/|#|mailto:)/i.test(link)) return m;
      let abs = path.posix.normalize((srcDir ? srcDir + "/" : "") + link);
      abs = abs.replace(/(^|\/)README\.md$/i, "$1").replace(/\.md$/i, "/");
      if (!abs.endsWith("/")) abs += "/";
      abs = abs.replace(/^\.?\//, "").replace(/^\/+/, "");
      return `href="${prefix}/${abs}${hash || ""}"`;
    });
  });

  // Only process files with `published: true` in frontmatter
  // Plus specific directories/files we explicitly include
  eleventyConfig.addCollection("published", function(collectionApi) {
    return collectionApi.getAll().filter(item => {
      return item.data.published === true;
    }).sort((a, b) => {
      // Sort by title alphabetically
      const titleA = (a.data.title || a.fileSlug).toLowerCase();
      const titleB = (b.data.title || b.fileSlug).toLowerCase();
      return titleA.localeCompare(titleB);
    });
  });

  // Group published pages by section
  eleventyConfig.addCollection("publishedBySection", function(collectionApi) {
    const sections = {};
    collectionApi.getAll()
      .filter(item => item.data.published === true)
      .forEach(item => {
        // Derive section from the file path
        const path = item.inputPath.replace(/^\.\//, '');
        const section = path.split('/')[0]; // research, career, projects, notes
        if (!sections[section]) sections[section] = [];
        sections[section].push(item);
      });
    // Sort each section
    for (const key of Object.keys(sections)) {
      sections[key].sort((a, b) => {
        const titleA = (a.data.title || a.fileSlug).toLowerCase();
        const titleB = (b.data.title || b.fileSlug).toLowerCase();
        return titleA.localeCompare(titleB);
      });
    }
    return sections;
  });

  // Pass through static assets
  eleventyConfig.addPassthroughCopy("research/economics/*.html");

  // Ignore non-publishable directories entirely
  eleventyConfig.ignores.add("raw/**");
  eleventyConfig.ignores.add("logs/**");
  eleventyConfig.ignores.add("tasks/**");
  eleventyConfig.ignores.add("projects/_template.md");
  eleventyConfig.ignores.add("node_modules/**");
  eleventyConfig.ignores.add(".claude/**");
  eleventyConfig.ignores.add(".git/**");
  eleventyConfig.ignores.add("career/slides/**");
  eleventyConfig.ignores.add("career/demo-video.mp4");
  eleventyConfig.ignores.add("career/demo-slides.html");
  eleventyConfig.ignores.add("career/demo-slides.md");
  eleventyConfig.ignores.add("README.md");
  eleventyConfig.ignores.add("CLAUDE.md");
  eleventyConfig.ignores.add("2026-04-07.md");

  // Only build markdown files that have `published: true`
  // This prevents Nunjucks from choking on Obsidian/Dataview syntax in unpublished files
  eleventyConfig.addPreprocessor("drafts", "md", (data, content) => {
    if (data.published !== true) {
      return false; // skip this file
    }
  });

  return {
    dir: {
      input: ".",
      output: "_site",
      includes: "_includes",
      data: "_data"
    },
    // Markdown bodies are NOT run through Nunjucks: Obsidian/Dataview syntax
    // ({{ }} / {% %}, literal braces, code examples) renders literally instead
    // of breaking the build. Layouts (njk) and the resolveMdLinks transform are
    // unaffected. (Was "njk" — see the per-file templateEngineOverride hack we
    // could then drop.)
    markdownTemplateEngine: false,
    htmlTemplateEngine: "njk",
    templateFormats: ["md", "njk", "html"],
    // Root locally; /Vault/ on GitHub Pages (set via PATH_PREFIX env var in the deploy workflow).
    // Templates must use the `| url` filter on links for this to take effect.
    pathPrefix: process.env.PATH_PREFIX || "/"
  };
};

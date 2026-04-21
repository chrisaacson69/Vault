module.exports = function(eleventyConfig) {

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
  eleventyConfig.ignores.add("tags/**");
  eleventyConfig.ignores.add("notes/**");
  eleventyConfig.ignores.add("projects/**");
  eleventyConfig.ignores.add("node_modules/**");
  eleventyConfig.ignores.add(".claude/**");
  eleventyConfig.ignores.add(".git/**");
  eleventyConfig.ignores.add("career/slides/**");
  eleventyConfig.ignores.add("career/demo-video.mp4");
  eleventyConfig.ignores.add("career/demo-slides.html");
  eleventyConfig.ignores.add("career/demo-slides.md");
  eleventyConfig.ignores.add("README.md");
  eleventyConfig.ignores.add("CLAUDE.md");
  eleventyConfig.ignores.add("INDEX.md");
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
    markdownTemplateEngine: "njk",
    htmlTemplateEngine: "njk",
    templateFormats: ["md", "njk", "html"]
  };
};

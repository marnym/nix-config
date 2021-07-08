require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "bash",
    "bibtex",
    "c",
    "comment",
    "cmake",
    "cpp",
    "css",
    "dockerfile",
    "go",
    "html",
    "java",
    "javascript",
    "json",
    "kotlin",
    "latex",
    "lua",
    "python",
    "rust",
    "scala",
    "scss",
    "tsx",
    "typescript",
    "vue",
    "yaml"
  },
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
  rainbow = {
    enable = true,
    extended = true,
    max_file_lines = 1000
  }
}

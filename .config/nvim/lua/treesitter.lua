require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "c",
    "commonlisp",
    "css",
    "elixir",
    "go",
    "haskell",
    "html",
    "htmldjango",
    "javascript",
    "python",
    "racket",
    "rust",
    "scheme",
    "typescript",
  },
  highlight = { enable = true },
}

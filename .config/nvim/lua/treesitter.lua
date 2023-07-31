require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "c",
    "python",
    "haskell",
    "scheme",
    "go",
    "rust",
    "racket",
    "commonlisp",
    "javascript",
    "typescript",
    "html",
    "css",
    "htmldjango",
  },
  highlight = { enable = true },
}

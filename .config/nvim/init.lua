vim.o.runtimepath = table.concat({
  vim.fn.expand("~/.vim"),
  vim.o.runtimepath,
  vim.fn.expand("~/.vim/after")
}, ",")
vim.o.packpath = vim.o.runtimepath

vim.o.guicursor = table.concat({vim.o.guicursor, "i:hor25-Cursor/lCursor"}, ",")
vim.cmd("set completeopt-=preview")
vim.cmd("set clipboard+=unnamedplus")

vim.cmd("runtime vimrc")

require("lsp")
require("colorizer").setup()
require("treesitter")

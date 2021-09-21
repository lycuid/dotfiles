set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

set guicursor+=i:hor25-Cursor/lCursor
set clipboard+=unnamedplus

packadd! coc.nvim

runtime vimrc
runtime vimrc.d/coc.vim

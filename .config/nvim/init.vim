set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

set guicursor+=i:hor25-Cursor/lCursor
set clipboard+=unnamedplus

packadd! coc.nvim
packadd! typescript-vim
packadd! vim-jsx-typescript

runtime vimrc
runtime vimrc.d/coc.vim

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

source ~/.vim/vimrc

" copy/paste from system clipboard.
set clipboard+=unnamedplus

" remove gui tabline.
silent! :call rpcnotify(1, 'Gui', 'Option', 'Tabline', 0)


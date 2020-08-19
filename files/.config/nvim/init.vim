set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

source ~/.vim/vimrc

" copy/paste from clipboard.
set clipboard+=unnamedplus

silent! :call rpcnotify(1, 'Gui', 'Option', 'Tabline', 0)


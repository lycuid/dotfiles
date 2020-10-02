set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

runtime vimrc

" remove gui tabline.
silent! :call rpcnotify(1, 'Gui', 'Option', 'Tabline', 0)
set guicursor+=i:hor25-Cursor/lCursor


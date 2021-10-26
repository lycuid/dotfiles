set colorcolumn=81
set cursorline
set termguicolors
colorscheme old_school

" nerdcommenter configs.
let g:NERDSpaceDelims=1
let g:NERDDefaultAlign='left'

"" git gutter settings
set updatetime=100 " ms.

"" fzf keymap.
nnoremap <c-p> :GFiles<cr>
nnoremap <c-b> :Buffers<cr>

"" GVIM settings.
if has("gui_running")
  "" ctrl+F1 toggle menubar.
  nnoremap <c-f1> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>

  set go-=T  "" REMOVES TOOLBAR
  set go-=r  "" REMOVES RIGHT SCROLLBAR
  set go-=L  "" REMOVES LEFT SCROLLBAR
  set go-=m  "" REMOVES MENUBAR

  set guifont=BlexMono\ Nerd\ Font\ 12
endif

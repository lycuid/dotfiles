set colorcolumn=81  " wrap indicator
set cursorline      " highlight current line

" colorscheme.
if expand("$TERM") !~ "rxvt"
  set termguicolors
end

set t_Co=256
colorscheme old_school

" nerdcommenter configs.
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'

"" indentLine settings.
let g:indentLine_enabled=1

"" git gutter settings
set updatetime=100 " ms.

"" fzf keymap.
nnoremap <C-p> :GFiles<CR>
nnoremap <leader>b :Buffers<CR>

"" GVIM settings.
if has("gui_running")
  "" ctrl+F1 toggle menubar.
  nnoremap <C-F1> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>

  set go-=T  "" REMOVES TOOLBAR
  set go-=r  "" REMOVES RIGHT SCROLLBAR
  set go-=L  "" REMOVES LEFT SCROLLBAR
  set go-=m  "" REMOVES MENUBAR

  set guifont=Hack\ Nerd\ Font\ 11
endif


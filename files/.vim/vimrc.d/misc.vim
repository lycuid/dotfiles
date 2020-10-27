set colorcolumn=81  " wrap indicator
set cursorline      " highlight current line
set guifont=BlexMono\ Nerd\ Font:h11

" colorscheme.
if expand("$TERM") !~ "rxvt"
  set termguicolors
end
set t_Co=256
colorscheme old_school

nnoremap <F11> :Goyo<CR>

"" indentLine settings.
let g:indentLine_enabled=1

"" git gutter settings
set updatetime=100 " ms.

"" fzf keymap.
nnoremap <C-p> :GFiles<CR>

" "" haskell and cabal syntax higlightling
" let g:haskell_enable_quantification=1 " to enable highlighting of forall
" let g:haskell_enable_recursivedo=1 " to enable highlighting of mdo and rec
" let g:haskell_enable_arrowsyntax=1 " to enable highlighting of proc
" let g:haskell_enable_pattern_synonyms=1 " to enable highlighting of pattern
" let g:haskell_enable_typeroles=1 " to enable highlighting of type roles
" let g:haskell_enable_static_pointers=1 " to enable highlighting of static

"" GVIM settings.
if has("gui_running")

  "" ctrl+F1 toggle mebubar
  nnoremap <C-F1> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>

  set go-=T  "" REMOVES TOOLBAR
  set go-=r  "" REMOVES RIGHT SCROLLBAR
  set go-=L  "" REMOVES LEFT SCROLLBAR
  set go-=m  "" REMOVES MENUBAR
endif


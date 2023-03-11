set colorcolumn=81
set cursorline

"" NERDCommenter.
let g:NERDSpaceDelims=1
let g:NERDCompactSexyComs=1
let g:NERDDefaultAlign='left'
let g:NERDCommentEmptyLines=1
let g:NERDTrimTrailingWhitespace=1

"" GitGutter.
set updatetime=100 " ms.
nnoremap <leader>gp :GitGutterPreviewHunk<cr>
set signcolumn=yes

"" Airline.
let g:airline_powerline_fonts=1
let g:airline_theme='transparent'
let g:airline#extensions#tabline#enabled=1

"" FZF.
nnoremap <c-p> :GFiles<cr>
nnoremap <c-a-p> :Files<cr>
nnoremap <c-b> :Buffers<cr>

"" GVIM settings.
set guifont=FiraCode\ Nerd\ Font:h11
let g:neovide_transparency=0.65
if has("gui_running")
  set go-=T  "" removes toolbar
  set go-=r  "" removes right scrollbar
  set go-=L  "" removes left scrollbar
  set go-=m  "" removes menubar
endif

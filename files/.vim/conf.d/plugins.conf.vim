"" indentLine settings.
let g:indentLine_enabled=1

"" git gutter settings
set updatetime=100 " ms.

"" ctrl-p settings.
" CtrlP REMAP TO ctrl+p
let g:ctrlp_map='<c-p>'
let g:ctrlp_cmd='CtrlP'

" ignores all files/dirs ignored by current git.
let g:ctrlp_user_command=['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" ctrlp ignore unecessary files.
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

" "" haskell and cabal syntax higlightling
" let g:haskell_enable_quantification=1 " to enable highlighting of forall
" let g:haskell_enable_recursivedo=1 " to enable highlighting of mdo and rec
" let g:haskell_enable_arrowsyntax=1 " to enable highlighting of proc
" let g:haskell_enable_pattern_synonyms=1 " to enable highlighting of pattern
" let g:haskell_enable_typeroles=1 " to enable highlighting of type roles
" let g:haskell_enable_static_pointers=1 " to enable highlighting of static



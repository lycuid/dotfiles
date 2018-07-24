" DEFAULT WINDOWS _vimrc SETTINGS

set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" MY PERSONAL .vimrc SETTINGS
"
"" COMMON SETTINGS
syntax enable
set number
set mouse=a
set encoding=utf-8

set fileformat=unix  "" EOL>> <LF> LINE FEED
set et ts=2 sw=2 softtabstop=0 "" noet (use tabs [\t]), ts (tabstop [tab size]), sw (shiftwidth [no of tabs])
"" set smarttab
set list listchars=eol:^,tab:\|\ 
color moody
let g:indentLine_enabled=1

"" NO SWAP AND BACKUP FILES
set nobackup
set nowritebackup
set noswapfile
set noundofile

"" SET LINE WRAP HIGHLIGHT AFTER 81 CHARACTERS
augroup vimrc_autocmds
  autocmd BufEnter * highlight OverLength ctermbg=darkgrey guibg=#592929
  autocmd BufEnter * match OverLength /\%81v.*/
augroup END

"" COLOR SCHEME
set t_Co=256  "" 256 COLOR

autocmd BufReadPost * if &ft !~? 'haskell' | call CSyntaxAfter() | endif

"" indent autoenabled
let g:indentLine_enabled=0
let g:indentLine_char='¦'

"" VIM-POWERLINE
set laststatus=2

"" CTRL-P FILE MANAGER
" CtrlP REMAP TO ctrl+p
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" CTRLP IGNORE UNECESSARY FILES
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

"" TAB COMPLETION IF LINE NOT EMPTY (CTRL+N)
"  CLEVER TAB
function! CleverTab()
  if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
    return "\<Tab>"
  else
    return "\<C-N>"
  endif
endfunction
inoremap <Tab> <C-R>=CleverTab()<CR>

"" CPP SYNTAX HIGHLIGHTING
let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_template_highlight = 1

"" HASKELL AND CABAL SYNTAX HIGLIGHTLING
let g:haskell_enable_quantification = 1 " to enable highlighting of forall
let g:haskell_enable_recursivedo = 1 " to enable highlighting of mdo and rec
let g:haskell_enable_arrowsyntax = 1 " to enable highlighting of proc
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of pattern
let g:haskell_enable_typeroles = 1 " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1 " to enable highlighting of static

"" MAP BUILDS FOR WINDOWS
autocmd FileType python nmap <buffer> <F5> :w<bar>!python3 %<CR>
autocmd FileType ruby nmap <buffer> <F5> :w<bar>!ruby %<CR>
autocmd FileType haskell nmap <buffer> <F5> :w<bar>!runhaskell %<CR>
autocmd FileType cpp nmap <buffer> <F5> :w<bar>!g++ -std=c++11 -o %:r % && ./%:r<CR>
autocmd FileType c nmap <buffer> <F5> :w<bar>!gcc -o %:r % && %:r<CR>
autocmd FileType go nmap <buffer> <F5> :w<bar>!go run %<CR>
autocmd FileType java nmap <buffer> <F5> :w<bar>!javac % && java %:r<CR>
autocmd FileType javascript nmap <buffer> <F5> :w<bar>!node %<CR>

map <C-w><C-t> :tabnew<CR>
"" TOGGLE TREE >> ctrl+n
map <C-n> :NERDTreeToggle<CR>

"" NERD-TREE
"" opens when no file is specified
"" autocmd StdinReadPre * let s:std_in=1
"" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"" close vim if nerdtree is the only window left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('cpp', 'green', 'none', '#990099', '#202020')
call NERDTreeHighlightFile('php', 'yellow', 'none', 'yellow', '#202020')
call NERDTreeHighlightFile('hs', 'blue', 'none', '#a0a0a0', '#202020')
call NERDTreeHighlightFile('txt', 'yellow', 'none', 'yellow', '#202020')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#202020')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#202020')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#202020')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#202020')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'red', '#202020')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'red', '#202020')
call NERDTreeHighlightFile('py', 'Red', 'none', '#ffa500', '#202020')
call NERDTreeHighlightFile('pyc', 'Red', 'none', '#99ff33', '#202020')
call NERDTreeHighlightFile('js', 'Red', 'none', '#6666ff', '#202020')
call NERDTreeHighlightFile('java', 'Magenta', 'none', '#ff99ff', '#202020')

"" NAVIGATION-ARROWS 
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

"" SET FONT
if has("gui_running")

  "" --FOR gVim (WINDOWS) ONLY --
  "" ctrl+F1 TOGGLE MEBUBAR
  nnoremap <C-F1> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>

  set go-=T  "" REMOVES TOOLBAR
  set go-=r  "" REMOVES RIGHT SCROLLBAR
  set go-=L  "" REMOVES LEFT SCROLLBAR
  set go-=m  "" REMOVES MENUBAR
  color moody
  let g:indentLine_enabled=1

  if has("gui_win32")
    set guifont=Lucida\ Console:h10:cANSI
  elseif has("gui_gtk+")
    set guifont=Inconsolata\ 10
  endif
endif

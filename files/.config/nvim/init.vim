call plug#begin('~/.vim/plugged')

"" Autocompletion.
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"" File navigation.
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'

"" SCM.
Plug 'tpope/vim-fugitive'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'

"" Display.
Plug 'ryanoasis/vim-devicons'
Plug 'Yggdroot/indentLine'

" statusbar.
Plug 'vim-airline/vim-airline'

" colorscheme.
Plug 'sainnhe/edge'

" Syntax.
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

Plug 'scrooloose/nerdcommenter'
Plug 'rust-lang/rust.vim'

call plug#end()


filetype plugin indent on
set autoindent
set colorcolumn=72                " wrap indicator
set cursorline                    " highlight current line
set relativenumber                " line number (relative).
set mouse=a                       " mouse click navigation.
set encoding=utf-8
set et ts=2 sw=2 softtabstop=0
set incsearch                     " highlight search as you type.
set hlsearch                      " highlight search words.
set fileformat=unix
set list listchars=eol:^,tab:--

"" no swap and backup files.
set nobackup
set nowritebackup
set noswapfile
set noundofile

" colorscheme.
set t_Co=256  "" 256 COLOR
set background=dark
set termguicolors
colorscheme edge

if has("nvim")
  " copy/paste from clipboard.
  set clipboard+=unnamedplus
endif

"" Useful Macros.
" Tab navigation
map <C-w><C-t> :tabnew<CR>
map <C-PageUp> :tabprevious<CR>
map <C-PageDown> :tabnext<CR>

" page navigation.
map <C-k> <C-y>
map <C-j> <C-e>

nnoremap ,, :noh<CR>

"" indent block of code
" vmap <C-]> >
" vmap <C-[> <
"" indent single line of code
" nmap <C-]> >>
" nmap <C-[> <<

" edit my vimrc
nnoremap <C-F6> :e $MYVIMRC<CR>

" reloading
nnoremap <C-F5> :source $MYVIMRC<CR>

" force of habit (sometimes).
nnoremap <C-s> :w<CR>

nnoremap <C-Up> <C-y>
nnoremap <C-Down> <C-e>

" code/code-block navigation.
nnoremap <C-S-Up> :m .-2<CR>==
nnoremap <C-S-Down> :m .+1<CR>==
inoremap <C-S-Up> <ESC>:m .-2<CR>==gi
inoremap <C-S-Down> <ESC>:m .+1<CR>==gi
vnoremap <C-S-Up> :m '<-2<CR>gv=gv
vnoremap <C-S-Down> :m '>+1<CR>gv=gv

command! RN :NERDTreeCWD <bar> NERDTreeRefreshRoot <bar> CtrlPClearCache<CR>


"" settings coc.
" if hidden is not set, TextEdit might fail.
set hidden

" Better display for messages
" set cmdheight=2

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
" nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)


" Use `:Format` to format current buffer:w
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-highlight',
  \ 'coc-rls',
  \ 'coc-tsserver',
  \ 'coc-eslint',
  \ 'coc-json',
  \ 'coc-emmet',
  \ ]


"" airline
let g:airline_powerline_fonts=1
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#tabline#enabled=1

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



" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags


"" cpp syntax highlighting
let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_template_highlight = 1


"" haskell and cabal syntax higlightling
let g:haskell_enable_quantification = 1 " to enable highlighting of forall
let g:haskell_enable_recursivedo = 1 " to enable highlighting of mdo and rec
let g:haskell_enable_arrowsyntax = 1 " to enable highlighting of proc
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of pattern
let g:haskell_enable_typeroles = 1 " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1 " to enable highlighting of static

"" Build systems (inline).
autocmd FileType python nmap <buffer> <F5> :w<bar>!python3 %<CR>
autocmd FileType ruby nmap <buffer> <F5> :w<bar>!ruby %<CR>
autocmd FileType haskell nmap <buffer> <F5> :w<bar>!runhaskell %<CR>
autocmd FileType lisp nmap <buffer> <F5> :w<bar>!clisp %<CR>
autocmd FileType cpp nmap <buffer> <F5> :w<bar>!g++ -std=c++11 -o %:r % && ./%:r<CR>
autocmd FileType c nmap <buffer> <F5> :w<bar>!gcc -o %:r % && %:r<CR>
autocmd FileType go nmap <buffer> <F5> :w<bar>!go run %<CR>
autocmd FileType java nmap <buffer> <F5> :w<bar>!javac % && java %:r<CR>
autocmd FileType javascript nmap <buffer> <F5> :w<bar>!node %<CR>


"" NERDTree Settings.
"" nerdtree toggle.
map <C-n> :NERDTreeToggle<CR>

"" close vim if nerdtree is the only window left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

let g:NERDTreeIgnore=['^node_modules$', '^\.git$']
let g:NERDTreeShowHidden=1

"" nerdtree navigation icons.
let g:NERDTreeDirArrowExpandable='▸'
let g:NERDTreeDirArrowCollapsible='▾'

"" nerd commenter mapping
vnoremap <C-/> <plug>NERDCommenterToggle
nnoremap <C-/> <plug>NERDCommenterToggle
let g:NERDSpaceDelims=1
let g:NERDCompactSexyComs=1
let g:NERDDefaultAlign='left'
let g:NERDCommentEmptyLines=1
let g:NERDTrimTrailingWhitespace=1

"" Nerdtree icons.
"" refreshing devicons, visual bug (brackets around icons).
if exists('g:loaded_webdevicons')
  call webdevicons#refresh()
endif

"" Nerdtree git icons (nerdtree-git-plugin).
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }



"" nvim settings
if has('nvim')

  function OpenTerminal()
    exec 'tabnew'
    if has('win32')
      exec 'terminal gitb'
    else
      exec 'terminal'
    endif
  endfunction

  " open terminal in new window (for neovim).
  nnoremap tt :call OpenTerminal()<CR>

  " escape terminal mode (while in terminal mode) (only neovim).
  tnoremap <ESC> <C-\><C-n>
endif


"" GVIM settings.
if has("gui_running")

  "" auto fullscreen on gvim
  autocmd GUIEnter * simalt ~x

  "" underscore cursor
  set guicursor+=i:hor20-Cursor/lCursor

  "" ctrl+F1 TOGGLE MEBUBAR
  nnoremap <C-F1> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>

  set go-=T  "" REMOVES TOOLBAR
  set go-=r  "" REMOVES RIGHT SCROLLBAR
  set go-=L  "" REMOVES LEFT SCROLLBAR
  set go-=m  "" REMOVES MENUBAR
endif


"" GVIM/nvim combined settings
if has("nvim") || has("gui_running")
  "" Downloaded from:
  "" https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/
  set guifont=BlexMono\ Nerd\ Font:h10
endif


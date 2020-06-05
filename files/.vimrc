if empty(glob('~/.vim/autoload/plug.vim'))
  exec '!mkdir -p ~/.vim/autoload && curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  let g:plug_fresh_install=1
end

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
Plug 'rust-lang/rust.vim'

Plug 'scrooloose/nerdcommenter'

call plug#end()

if exists('g:plug_fresh_install')
  silent PlugInstall
  silent quit
  unlet g:plug_fresh_install
end


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
let g:edge_transparent_background=1
colorscheme edge

" Tab navigation
map <C-w><C-t> :tabnew<CR>
map <C-PageUp> :tabprevious<CR>
map <C-PageDown> :tabnext<CR>

" page navigation.
map <C-k> <C-y>
map <C-j> <C-e>

" comments.
map <C-/> <plug>NERDCommenterToggle
map <C-/> <plug>NERDCommenterToggle

nnoremap ,, :noh<CR>

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

"" Build.
autocmd FileType python nmap <buffer> <F5> :w<bar>!python3 %<CR>
autocmd FileType ruby nmap <buffer> <F5> :w<bar>!ruby %<CR>
autocmd FileType haskell nmap <buffer> <F5> :w<bar>!runhaskell %<CR>
autocmd FileType lisp nmap <buffer> <F5> :w<bar>!clisp %<CR>
autocmd FileType cpp nmap <buffer> <F5> :w<bar>!g++ -std=c++11 -o %:r % && ./%:r<CR>
autocmd FileType c nmap <buffer> <F5> :w<bar>!gcc -o %:r % && %:r<CR>
autocmd FileType go nmap <buffer> <F5> :w<bar>!go run %<CR>
autocmd FileType java nmap <buffer> <F5> :w<bar>!javac % && java %:r<CR>
autocmd FileType javascript nmap <buffer> <F5> :w<bar>!node %<CR>

"" Downloaded from: https://github.com/ryanoasis/nerd-fonts/
" needed this to be available globally as although 'if gvim running?' can
" be determined but `nvim-qt` cannnot (yet).
set guifont=BlexMono\ Nerd\ Font:h10

"" GVIM settings.
if has("gui_running")

  "" auto fullscreen on gvim
  autocmd GUIEnter * simalt ~x

  "" underscore cursor
  set guicursor+=i:hor20-Cursor/lCursor

  "" ctrl+F1 toggle mebubar
  nnoremap <C-F1> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>

  set go-=T  "" REMOVES TOOLBAR
  set go-=r  "" REMOVES RIGHT SCROLLBAR
  set go-=L  "" REMOVES LEFT SCROLLBAR
  set go-=m  "" REMOVES MENUBAR
endif

" coc.
source ~/.vim/conf.d/coc.conf.vim

" airline.
source ~/.vim/conf.d/airline.conf.vim

" nerdtree/nerdcommenter.
source ~/.vim/conf.d/nerdtree.conf.vim

" rest.
source ~/.vim/conf.d/plugins.conf.vim


autocmd FileType python setlocal makeprg=python\ %
autocmd FileType haskell setlocal makeprg=runhaskell\ %
autocmd FileType rust setlocal makeprg=rustc\ %\ &&\ \.\/%:r
autocmd FileType go setlocal makeprg=go\ run\ %
autocmd FileType cpp setlocal makeprg=g++\ -std=c++11\ \-o\ %:r\ %\ &&\ \.\/%:r
autocmd FileType c setlocal makeprg=cc\ \-o\ %:r\ %\ &&\ \.\/%:r
autocmd FileType lisp setlocal makeprg=clisp\ %

nnoremap <f5> :make!<cr>

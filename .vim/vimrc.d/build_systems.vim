autocmd FileType asm setlocal makeprg=as\ %\ -o\ %:r.o\ &&\ ld\ %:r.o\ -o\ %:r\ &&\ ./%:r
autocmd FileType python setlocal makeprg=python\ %
autocmd FileType haskell setlocal makeprg=runhaskell\ %
autocmd FileType rust setlocal makeprg=rustc\ %\ &&\ ./%:r
autocmd FileType go setlocal makeprg=go\ run\ %
autocmd FileType cpp setlocal makeprg=g++\ -Wall\ -Wextra\ -pedantic\ -std=c++14\ -o\ %:r\.out\ %\ &&\ ./%:r\.out
autocmd FileType c setlocal makeprg=cc\ -Wall\ -Wextra\ -pedantic\ -std=c99\ -o\ %:r\.out\ %\ &&\ ./%:r\.out
autocmd FileType lisp setlocal makeprg=clisp\ %
autocmd FileType scheme setlocal makeprg=guile\ %

nnoremap <f5> :make!<cr>

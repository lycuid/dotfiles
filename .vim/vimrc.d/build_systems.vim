autocmd FileType python nmap <buffer> <f5> :w<bar>!python %<cr>
autocmd FileType haskell nmap <buffer> <f5> :w<bar>!runhaskell %<cr>
autocmd FileType rust nmap <buffer> <f5> :w<bar>!rustc % && ./%:r<cr>
autocmd FileType go nmap <buffer> <f5> :w<bar>!go run %<cr>
autocmd FileType cpp nmap <buffer> <f5> :w<bar>!g++ -std=c++11 -o %:r % && ./%:r<cr>
autocmd FileType c nmap <buffer> <f5> :w<bar>!gcc -o %:r % && ./%:r<cr>
autocmd FileType lisp nmap <buffer> <f5> :w<bar>!clisp %<cr>

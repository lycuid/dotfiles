autocmd FileType python nmap <buffer> <F5> :w<bar>!python3 %<CR>
autocmd FileType haskell nmap <buffer> <F5> :w<bar>!runhaskell %<CR>
autocmd FileType rust nmap <buffer> <F5> :w<bar>!rustc % && ./%:r<CR>
autocmd FileType go nmap <buffer> <F5> :w<bar>!go run %<CR>
autocmd FileType cpp nmap <buffer> <F5> :w<bar>!g++ -std=c++11 -o %:r % && ./%:r<CR>
autocmd FileType c nmap <buffer> <F5> :w<bar>!gcc -o %:r % && ./%:r<CR>
autocmd FileType javascript nmap <buffer> <F5> :w<bar>!node %<CR>
autocmd FileType lisp nmap <buffer> <F5> :w<bar>!clisp %<CR>
autocmd FileType ruby nmap <buffer> <F5> :w<bar>!ruby %<CR>
autocmd FileType java nmap <buffer> <F5> :w<bar>!javac % && java %:r<CR>


autocmd FileType rust nmap <buffer> <leader>f :w<cr>:silent !rustfmt %<cr>:e<cr>
autocmd FileType go nmap <buffer> <leader>f :w<cr>:silent !gofmt -w %<cr>:e<cr>
autocmd FileType c,cpp nmap <buffer> <leader>f :w<cr>:silent !clang-format -i %<cr>:e<cr>
autocmd FileType javascript,typescript,typescriptreact,javascriptreact nmap <buffer> <leader>f :w<cr>:silent !prettier --write %<cr>:e<cr>

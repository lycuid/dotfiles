autocmd FileType rust nnoremap <buffer> <leader>f :w<CR>:silent !rustfmt %<CR>:e<CR>
autocmd FileType go nnoremap <buffer> <leader>f :w<CR>:silent !gofmt -w %<CR>:e<CR>
autocmd FileType c,cpp nnoremap <buffer> <leader>f :w<CR>:silent !clang-format -i %<CR>:e<CR>

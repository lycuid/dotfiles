autocmd Filetype rust nnoremap <leader>f :w<CR>:silent !rustfmt %<CR>:e<CR>
autocmd Filetype go nnoremap <leader>f :w<CR>:silent !gofmt -w %<CR>:e<CR>
autocmd Filetype c,cpp nnoremap <leader>f :w<CR>:silent !clang-format -i %<CR>:e<CR>

let lang_formatters = {
  \ "rust":     "rustfmt",
  \ "haskell":  "stylish-haskell",
  \ "go":       "gofmt",
  \ "c,cpp":    "clang-format",
  \ "javascript,typescript,javascriptreact,typescriptreact": "prettier",
  \ }

for [lang, formatter] in items(lang_formatters)
  execute 'autocmd FileType ' . lang . ' nmap <buffer> <leader>f mx:%!' . formatter . '<cr>`x'
  execute 'autocmd FileType ' . lang . ' :set formatprg=' . formatter
endfor

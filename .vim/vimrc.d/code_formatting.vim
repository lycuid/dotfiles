let lang_formatters = #{
  \ haskell:          "stylish-haskell",
  \ rust:             "rustfmt",
  \ python:           "black",
  \ go:               "gofmt",
  \ c:                "clang-format",
  \ cpp:              "clang-format",
  \ javascript:       "prettier",
  \ typescript:       "prettier",
  \ javascriptreact:  "prettier",
  \ typescriptreact:  "prettier",
  \ }

for [lang, formatter] in items(lang_formatters)
  execute 'autocmd FileType ' . lang . ' nmap <buffer> <leader>f :%!' . formatter . '<cr>``'
  execute 'autocmd FileType ' . lang . ' :set formatprg=' . formatter
endfor

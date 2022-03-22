let lang_formatters = #{
  \ haskell:          "stylish-haskell",
  \ rust:             "rustfmt",
  \ python:           "autopep8",
  \ go:               "gofmt",
  \ c:                "clang-format",
  \ cpp:              "clang-format",
  \ javascript:       "prettier",
  \ typescript:       "prettier",
  \ javascriptreact:  "prettier",
  \ typescriptreact:  "prettier",
  \ }

for [lang, formatter] in items(lang_formatters)
  execute 'autocmd FileType ' . lang . ' nmap <buffer> <leader>f mx:%!' . formatter . '<cr>`x'
  execute 'autocmd FileType ' . lang . ' :set formatprg=' . formatter
endfor

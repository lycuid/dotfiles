function GetFileTypeString()
  let sym = exists("*WebDevIconsGetFileTypeSymbol") 
        \ ? WebDevIconsGetFileTypeSymbol() : ''
  return &ft!=#'' ? join([sym, &ft, '| '], ' ') : ''
endfunction

function GetFileFormatString()
  let sym = exists("*WebDevIconsGetFileFormatSymbol") 
        \ ? WebDevIconsGetFileFormatSymbol() : '[' . &ff . ']'
  return &ff!=#'' ? join([&fenc, sym, '| '], ' ') : ''
endfunction

set laststatus=2

highlight User1 ctermfg=15 ctermbg=8 guifg=#efefef guibg=#252525
highlight User2 ctermbg=233 guibg=#101010

" Left.
set statusline=%1*%.30f%m                 " filepath, modified status.
set statusline+=\ %2*\ %h%r%w             " help, readonly, preview.

" Seperator.
set statusline+=%=

" Right.
set statusline+=%{GetFileTypeString()}    " FileTypeSymbol FileTypeString.
set statusline+=%{GetFileFormatString()}  " FileEncoding FileFormatSymbol.
set statusline+=%v\:%l\/%L\ \%3p%%\       " col:row/total_rows percentage.

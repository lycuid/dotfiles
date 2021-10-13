" symbol functions shipped with 'ryanoasis/vim-devicons'.
function GetFileTypeString()
  let sym = exists("*WebDevIconsGetFileTypeSymbol") 
        \ ? WebDevIconsGetFileTypeSymbol() : ""
  return &ft!=#"" ? join([sym, &ft, "| "], " ") : ""
endfunction

function GetFileFormatString()
  let sym = exists("*WebDevIconsGetFileFormatSymbol") 
        \ ? WebDevIconsGetFileFormatSymbol() : "[" . &ff . "]"
  return &ff!=#"" ? join([&fenc, sym, "| "], " ") : ""
endfunction

set laststatus=2

" Left.
set statusline=\ %.30f%m                  " filepath, modified status.
set statusline+=\ %h%r%w                  " help, readonly, preview.

" Seperator.
set statusline+=%=

" Right.
set statusline+=%{GetFileTypeString()}    " FileTypeSymbol FileTypeString.
set statusline+=%{GetFileFormatString()}  " FileEncoding FileFormatSymbol.
set statusline+=%v\:%l\/%L\ \%3p%%\       " col:row/total_rows percentage.

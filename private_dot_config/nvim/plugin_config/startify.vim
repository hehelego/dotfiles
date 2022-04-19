" see https://github.com/mhinz/vim-startify
" see https://github.com/ryanoasis/vim-devicons

function! StartifyEntryFormat()
  return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
endfunction

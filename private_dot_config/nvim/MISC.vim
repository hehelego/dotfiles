" set expandtab when indentation is used to delimit code block
augroup filetype_expandtab
  autocmd!

  autocmd FileType haskell    setlocal expandtab
  autocmd FileType python     setlocal expandtab
  autocmd FileType lua        setlocal expandtab
  autocmd FileType vim        setlocal expandtab
  autocmd FileType markdown   setlocal expandtab
augroup END


" only display relative line number in terminal buffer
augroup term_lineno
  autocmd!

  autocmd TermOpen * setlocal nonumber
  autocmd TermOpen * setlocal relativenumber
augroup END

" disable line-number in quick-fix
augroup qf_nonu
  autocmd!

  autocmd FileType qf setlocal norelativenumber
  autocmd FileType qf setlocal nonumber
augroup END

set list
set listchars+=space:.

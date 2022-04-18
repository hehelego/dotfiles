let s:cs='onedark'

" see https://github.com/morhetz/gruvbox
if s:cs=='gruvbox'
  let g:gruvbox_bold=1
  let g:gruvbox_italic=1
  let g:gruvbox_transparent_bg=1
  let g:gruvbox_underline=1
  let g:gruvbox_undercurl=1
  let g:gruvbox_termcolors=256


  let g:airline_theme='gruvbox'
  colorscheme gruvbox

  augroup set_colorscheme
    autocmd!
    autocmd vimenter * ++nested colorscheme gruvbox
  augroup END
endif


" see https://github.com/joshdick/onedark.vim
if s:cs=='onedark'
  let g:onedark_termcolors=256
  let g:onedark_terminal_italics=1
  let g:onedark_hide_endofbuffer=1

  let g:airline_theme='onedark'
  colorscheme onedark

  augroup set_colorscheme
    autocmd!
    autocmd vimenter * ++nested colorscheme onedark
  augroup END
endif

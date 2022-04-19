"""""""""""""""""""""""""
"      keymapping       "
"""""""""""""""""""""""""

"""""""""""""""""
" SECITON: MISC
"""""""""""""""""

" prevent lossing visual selection when performing shift operations
" -> allow shifting the selected block multiple times after selection
xnoremap < <gv
xnoremap > >gv

" (temporarily) turn off highlight search result: <Ctrl>+l
inoremap <silent><expr> <C-l> execute('nohlsearch')
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR>
xnoremap <silent> <C-l> :<C-u>nohlsearch<CR>gv

"""""""""""""""""
" SECITON: editor UI
"""""""""""""""""

function! ToggleMouse()
  if matchstr(&mouse,"a")=="a"
    set mouse-=a
  else
    set mouse=a
  endif
endfunction
function! ToggleTransparentBg()
  if !exists("g:transparent_bg_state")
    let g:transparent_bg_state = 0
  endif

  if g:transparent_bg_state==0
    let g:transparent_bg_state = 1
    highlight Normal guibg=NONE ctermbg=NONE
  else
    let g:transparent_bg_state = 0
    execute(":colorscheme " . g:colors_name)
  endif
endfunction

nnoremap <silent> <leader>em :<C-u>call ToggleMouse()<CR>

nnoremap <leader>et :<C-u>call ToggleTransparentBg()<CR>

nnoremap <silent> <leader>el :<C-u>set cursorline!<CR>
nnoremap <silent> <leader>ec :<C-u>set cursorcolumn!<CR>

nnoremap <silent> <leader>ea :<C-u>set number!<CR>
nnoremap <silent> <leader>er :<C-u>set relativenumber!<CR>

nnoremap <silent> <leader>ep :<C-u>RainbowToggle<CR>

nnoremap <silent> <leader>es :<C-u>Colors<CR>

""""""""""""""""""
" SECITON: buffer
""""""""""""""""""

" search contents in this buffer
nnoremap <silent> <leader>bf :BLines<CR>
" reload current buffer
nnoremap <silent> <leader>br :edit<CR>
" source the vimscript in current buffer
nnoremap <silent> <leader>bs :source %<CR>
" change file type
nnoremap <silent> <leader>bt :<C-u>Filetypes<CR>


""""""""""""""""""""""""""""""""""
" SECITON: windows/tabs/buffers
""""""""""""""""""""""""""""""""""

" manipulate window size
nnoremap <silent> <A-Left> :<C-u>vertical resize -3<CR>
nnoremap <silent> <A-Right> :<C-u>vertical resize +3<CR>
nnoremap <silent> <A-Down> :<C-u>resize -3<CR>
nnoremap <silent> <A-Up> :<C-u>resize +3<CR>


" switching between tabs
nnoremap <silent> <A-j> gt
nnoremap <silent> <A-k> gT
" moving tabs around 
nnoremap <silent> <A-J> :<C-u>tabmove +1<CR>
nnoremap <silent> <A-K> :<C-u>tabmove -1<CR>
" delete(close) a buffer
nnoremap <silent> <A-w> :<C-u>bdelete<CR>

" quickfix: open/close/jump-to-next-fix/jump-to-previous-fix
nnoremap <silent> <leader>qo :<C-u>copen<CR>
nnoremap <silent> <leader>qc :<C-u>cclose<CR>
nnoremap <silent> <leader>qn :<C-u>cnext<CR>
nnoremap <silent> <leader>qp :<C-u>cprevious<CR>


"""""""""""""""""
" SECITON: path
"""""""""""""""""

" insert path of current file
inoremap <silent><expr> <A-f> expand('%:p:t')
inoremap <silent><expr> <A-F> expand('%:p')

"""""""""""""""""
" SECITON: clipboard
"""""""""""""""""

" selected text <-> X11 xclip clipboard/primary
nnoremap <silent> <leader>yx "+y
xnoremap <silent> <leader>yx "+y<Esc>gv
nnoremap <silent> <leader>px "+p
xnoremap <silent> <leader>px "+p<Esc>gv
" selected text <-> X11 xclip primary
nnoremap <silent> <leader>yX "*y
xnoremap <silent> <leader>yX "*y<Esc>gv
nnoremap <silent> <leader>pX "*p
xnoremap <silent> <leader>pX "*p<Esc>gv


"""""""""""""""""
" SECITON: words look up
"""""""""""""""""

" lookup the word using [ydcv](https://github.com/farseerfc/ydcv-rs)
nnoremap <silent> <leader>w :<C-u>call <SID>dict_lookup(expand('<cword>'))<CR>
xnoremap <silent> <leader>w :<C-u>call <SID>dict_lookup(<SID>get_visual_selection())<CR>

" lookup a word in dictionary using ydcv
" 1. call ydcv dictionary lookup command,
" 2. vertically split window, 3. open a terminal in the bottom part
" 3. print the output
function! s:dict_lookup(word)
  call writefile([a:word], '/tmp/vim_ydcv_word')
  let l:bang = '!'
  let l:opt  = {
        \ 'mode'   : 'async',
        \ 'raw'    : 1,
        \ 'focus'  : 0 }
  let l:cmd  = 'cat /tmp/vim_ydcv_word | ydcv -n'
  call asyncrun#run(l:bang, l:opt, l:cmd)
endfunction

" return the selected text in visual mode
" credit https://stackoverflow.com/questions/1533565/how-to-get-visually-selected-text-in-vimscript
function! s:get_visual_selection()
  let [line_start, column_start] = getpos("'<")[1:2]
  let [line_end, column_end] = getpos("'>")[1:2]
  let lines = getline(line_start, line_end)
  if len(lines) == 0
      return ''
  endif
  let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][column_start - 1:]
  return join(lines, "\n")
endfunction


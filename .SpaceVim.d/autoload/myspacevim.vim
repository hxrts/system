
func! myspacevim#before() abort

endf

"--------------
" load spacevim
"--------------

func! myspacevim#after() abort

  " fast split navigation
  nnoremap <C-J> <C-W><C-J>
  nnoremap <C-K> <C-W><C-K>
  nnoremap <C-L> <C-W><C-L>
  nnoremap <C-H> <C-W><C-H>

  " hide nerdtree help dialogue
  let g:NERDTreeMinimalUI = v:true

endf


{ stdenv, writeText }:

''
" options
syntax on
set number
set numberwidth=3
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE 
=NON   E guifg=DarkGrey guibg=NONE
filetype plugin indent on
set backspace=indent,eol,start
''


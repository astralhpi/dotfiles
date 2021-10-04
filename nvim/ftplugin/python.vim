set ts=4
set sw=4
set colorcolumn=88

let g:black_linelength = 88
autocmd BufWritePre *.py execute ':Black'

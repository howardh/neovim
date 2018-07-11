filetype plugin on

call plug#begin('~/.vim/plugged')

Plug 'tmhedberg/SimpylFold'
Plug 'pangloss/vim-javascript'

Plug 'Shougo/deoplete.nvim'
Plug 'zchee/deoplete-jedi'

call plug#end()

let g:deoplete#enable_at_startup = 1

augroup javascript_folding
    au!
    au FileType javascript setlocal foldmethod=syntax
augroup END

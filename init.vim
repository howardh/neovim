filetype plugin on

call plug#begin('~/.vim/plugged')

" Buffer management
Plug 'zefei/vim-wintabs'
Plug 'zefei/vim-wintabs-powerline'

" Folding
Plug 'tmhedberg/SimpylFold'
Plug 'pangloss/vim-javascript'

" Autocomplete
Plug 'Shougo/deoplete.nvim'
Plug 'zchee/deoplete-jedi'

call plug#end()

" Deoplete
let g:deoplete#enable_at_startup = 1

" Wintabs
let g:wintabs_display = 'statusline'

" vim-javascript
augroup javascript_folding
    au!
    au FileType javascript setlocal foldmethod=syntax
augroup END

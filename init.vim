filetype plugin on

call plug#begin('~/.vim/plugged')

" Buffer management
Plug 'zefei/vim-wintabs'
Plug 'zefei/vim-wintabs-powerline'

" Folding
Plug 'tmhedberg/SimpylFold'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'

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

" General settings
set tabstop=2           " Render TABs using this many spaces.
set shiftwidth=2        " Indentation amount for < and > commands.
set expandtab        	" Spaces
set ignorecase          " Make searching case insensitive
set smartcase           " ... unless the query has capital letters.

set breakindent
set showbreak=>> 

" Sass settings
augroup sass_settings
    au!
    autocmd BufReadPost *.scss  set filetype=sass	" Set the filetype to sass if it's a *.scss file
    " Fold between braces
    autocmd Filetype sass setlocal foldmethod=marker
    autocmd Filetype sass setlocal foldmarker={,}
augroup END

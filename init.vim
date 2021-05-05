filetype plugin on
call plug#begin('~/.vim/plugged') 

" Folding
Plug 'tmhedberg/SimpylFold'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'

" Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Search/Replace
Plug 'skwp/greplace.vim'

" Ctrlspace
Plug 'vim-ctrlspace/vim-ctrlspace'

" Tab line
Plug 'vim-airline/vim-airline'

" NerdTree
Plug 'preservim/nerdtree'

call plug#end()

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
set ssop-=curdir
set ssop+=sesdir
set splitbelow " Open new horizontal splits below current split
set splitright " Open new vertical splits to the right of current split

inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

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

" Ctrlspace settings
set nocompatible
set hidden
set encoding=utf-8
let g:CtrlSpaceDefaultMappingKey = "<C-space> "

" CoC Settings
" Use `ctrl-j` and `ctrl-k` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> <c-k> <Plug>(coc-diagnostic-prev)
nmap <silent> <c-j> <Plug>(coc-diagnostic-next)
" 235 = grey15 (see https://jonasjacek.github.io/colors/)
hi Pmenu ctermbg=235 ctermfg=white

" Go to definition with `gd`
nmap <silent> <leader>gdd <Plug>(coc-definition)
nmap <silent> <leader>gdt * :call CocAction('jumpDefinition', 'tabe')<CR>
nmap <silent> <leader>gdv * :call CocAction('jumpDefinition', 'vsplit')<CR>
nmap <silent> <leader>gds * :call CocAction('jumpDefinition', 'split')<CR>

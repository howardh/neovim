filetype plugin on
call plug#begin('~/.vim/plugged') 

" Folding
Plug 'tmhedberg/SimpylFold'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'

" Misc
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Autocomplete
Plug 'skwp/greplace.vim' " Search/Replace
Plug 'vim-ctrlspace/vim-ctrlspace'
Plug 'vim-airline/vim-airline' " Tab line
Plug 'preservim/nerdtree'
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
Plug 'github/copilot.vim'

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
" Only jump to diagnostics that are severity "information" or higher. This
" allows hints (e.g. Pyright's unused variable) to be listed, but the
" shortcuts will not jump to them
"nmap <silent> <c-k> :call CocAction('diagnosticPrevious','error')<CR>
"nmap <silent> <c-j> :call CocAction('diagnosticNext','error')<CR>
nmap <silent> <c-K> <Plug>(coc-diagnostic-prev)
nmap <silent> <c-J> <Plug>(coc-diagnostic-next)
" 235 = grey15 (see https://jonasjacek.github.io/colors/)
hi Pmenu ctermbg=235 ctermfg=white
" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Extensions
let g:coc_global_extensions = [
            \ 'coc-pyright',
            \ 'coc-json',
            \ 'coc-html',
            \ 'coc-css',
            \ ]

" Go to definition with `gd`
nmap <silent> <leader>gdd <Plug>(coc-definition)
nmap <silent> <leader>gdt * :call CocAction('jumpDefinition', 'tabe')<CR>
nmap <silent> <leader>gdv * :call CocAction('jumpDefinition', 'vsplit')<CR>
nmap <silent> <leader>gds * :call CocAction('jumpDefinition', 'split')<CR>

" XML settings
augroup xml_settings
    au!
    let g:xml_syntax_folding=1
    autocmd FileType xml setlocal foldmethod=syntax
    autocmd FileType xml :%foldopen!
augroup END

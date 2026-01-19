local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

-- Folding
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})
Plug('tmhedberg/SimpylFold') -- Python folding
Plug('pangloss/vim-javascript')
Plug('maxmellon/vim-jsx-pretty')

-- Misc
Plug('neoclide/coc.nvim', {['branch'] = 'release'}) -- Autocomplete
Plug('skwp/greplace.vim') -- Search/Replace
--Plug('vim-ctrlspace/vim-ctrlspace')
Plug('vim-airline/vim-airline') -- Tab line
Plug('preservim/nerdtree')
Plug('github/copilot.vim')

Plug('nvim-lua/plenary.nvim') -- Telescope dependency
Plug('nvim-telescope/telescope.nvim', { ['branch'] = '0.1.x' }) -- Fuzzy finder
-- Also might want to install https://github.com/BurntSushi/ripgrep. I don't
-- know what it does, but a side-effect is that .gitignore files are respected,
-- which is all I care about. This needs to be installed via the system's
-- package manager, e.g. `sudo pacman -S ripgrep`.

vim.call('plug#end')


-- General settings
-- https://neovim.io/doc/user/lua-guide.html#_options
vim.opt.tabstop = 2           -- Render TABs using this many spaces.
vim.opt.shiftwidth = 2        -- Indentation amount for < and > commands.
vim.opt.expandtab = true   	  --  Spaces
vim.opt.ignorecase = true     -- Make searching case insensitive
vim.opt.smartcase = true      -- ... unless the query has capital letters.
vim.opt.ssop:remove("curdir")
vim.opt.ssop:append("sesdir")
vim.opt.splitbelow = true     -- Open new horizontal splits below current split
vim.opt.splitright = true     -- Open new vertical splits to the right of current split

vim.opt.breakindent = true
vim.opt.showbreak = ">> "


-- https://neovim.io/doc/user/lua-guide.html#lua-guide-mappings-set


-- CoC Settings
-- Use `ctrl-j` and `ctrl-k` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
-- Only jump to diagnostics that are severity "information" or higher. This
-- allows hints (e.g. Pyright's unused variable) to be listed, but the
-- shortcuts will not jump to them
--nmap <silent> <c-k> :call CocAction('diagnosticPrevious','error')<CR>
--nmap <silent> <c-j> :call CocAction('diagnosticNext','error')<CR>
vim.keymap.set('n', '<c-K>', '<Plug>(coc-diagnostic-prev)', {silent = true})
vim.keymap.set('n', '<c-J>', '<Plug>(coc-diagnostic-next)', {silent = true})
-- 235 = grey15 (see https://jonasjacek.github.io/colors/)
vim.cmd("hi Pmenu ctermbg=235 ctermfg=white")
-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice
vim.keymap.set("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], {silent = true, noremap = true, expr = true, replace_keycodes = false})

-- Go to definition with `gd`
vim.keymap.set("n", "<leader>gdd", "<Plug>(coc-definition)", { silent = true })
vim.keymap.set("n", "<leader>gdt", function()
  vim.fn.CocAction("jumpDefinition", "tabe")
end, { silent = true })
vim.keymap.set("n", "<leader>gdv", function()
  vim.fn.CocAction("jumpDefinition", "vsplit")
end, { silent = true })
vim.keymap.set("n", "<leader>gds", function()
  vim.fn.CocAction("jumpDefinition", "split")
end, { silent = true })

-- Telescope settings
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { noremap = true })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { noremap = true })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { noremap = true })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { noremap = true })

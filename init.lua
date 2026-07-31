local vim = vim
local Plug = vim.fn['plug#'] -- TODO: Switch to lazy.vim. Documentation for VimPlug are becoming increasingly sparse.

local hostname = vim.fn.hostname()
local MINUET_ENDPOINT = os.getenv('MINUET_ENDPOINT');

-- Plugins
vim.call('plug#begin')
  -- Pastel Colour Schemes
  Plug('catppuccin/nvim', {['as'] = 'catppuccin'})
  
  -- Folding
  -- You can check the file's current filetype with `:set filetype?`
  Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})
  Plug('tmhedberg/SimpylFold', { ['for'] = { 'python' } }) -- Python folding
  Plug('pangloss/vim-javascript', { ['for'] = { 'javascript', 'javascriptreact' } })
  Plug('maxmellon/vim-jsx-pretty', { ['for'] = { 'javascript', 'javascriptreact' } })
  
  -- Misc
  Plug('neoclide/coc.nvim', {['branch'] = 'release'}) -- Autocomplete (Requires neovim >= 0.8)
  Plug('skwp/greplace.vim') -- Search/Replace
  --Plug('vim-ctrlspace/vim-ctrlspace')
  Plug('vim-airline/vim-airline') -- Tab line
  Plug('preservim/nerdtree')
  --Plug('github/copilot.vim', { ['on'] = 'Copilot' })
  
  Plug(
    'milanglacier/minuet-ai.nvim',
     MINUET_ENDPOINT and {} or { ['on'] = {} }
  )
  --Plug('hrsh7th/nvim-cmp')       -- optional
  --Plug('Saghen/blink.cmp')       -- optional
  
  Plug('nvim-lua/plenary.nvim') -- Telescope dependency
  Plug('nvim-telescope/telescope.nvim', { ['branch'] = 'master' }) -- Fuzzy finder
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


-- Validation
-- This happens after the general settings
if vim.keymap == nil then
  local vim_version_str = vim.version().major .. "." .. vim.version().minor
  vim.notify("`vim.keymap` is nil. Requires Neovim>0.7. Currently on version " .. vim_version_str .. ".", vim.log.levels.ERROR)
  return
end


-- https://neovim.io/doc/user/lua-guide.html#lua-guide-mappings-set


-- Colour scheme
require("catppuccin").setup {
    custom_highlights = function(colors)
        return {
            -- See available colours here: https://github.com/catppuccin/catppuccin/blob/main/docs/style-guide.md
            WinSeparator = { fg = colors.overlay0 }, -- Make the vertical pane serparators visible
        }
    end,
    integrations = {
      coc_nvim = true,
    }
}
vim.cmd.colorscheme "catppuccin-mocha"


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

-- Copilot settings
-- Disable by default. It can be re-enabled as needed with `:Copilot enable`.
vim.g.copilot_enabled = false

-- Minuet-ai settings
if MINUET_ENDPOINT then
  require('minuet').setup {
      provider = 'openai_fim_compatible',
      n_completions = 1, -- recommend for local model for resource saving
      -- I recommend beginning with a small context window size and incrementally
      -- expanding it, depending on your local computing power. A context window
      -- of 512, serves as an good starting point to estimate your computing
      -- power. Once you have a reliable estimate of your local computing power,
      -- you should adjust the context window to a larger value.
      context_window = 512,
      provider_options = {
          openai_fim_compatible = {
              -- For Windows users, TERM may not be present in environment variables.
              -- Consider using APPDATA instead.
              api_key = 'TERM',
              name = 'Llama.cpp',
              --end_point = 'http://192.168.0.33:8012/v1/completions',
              end_point = MINUET_ENDPOINT,
              -- The model is set by the llama-cpp server and cannot be altered
              -- post-launch.
              model = 'PLACEHOLDER',
              optional = {
                  max_tokens = 56,
                  top_p = 0.9,
              },
              -- Llama.cpp does not support the `suffix` option in FIM completion.
              -- Therefore, we must disable it and manually populate the special
              -- tokens required for FIM completion.
              template = {
                  prompt = function(context_before_cursor, context_after_cursor, _)
                      return '<|fim_prefix|>'
                          .. context_before_cursor
                          .. '<|fim_suffix|>'
                          .. context_after_cursor
                          .. '<|fim_middle|>'
                  end,
                  suffix = false,
              },
          },
      },
      virtualtext = {
          auto_trigger_ft = {'python'},
          keymap = {
              -- accept whole completion
              accept = '<A-A>',
              -- accept one line
              accept_line = '<A-a>',
              -- accept n lines (prompts for number)
              -- e.g. "A-z 2 CR" will accept 2 lines
              accept_n_lines = '<A-z>',
              -- Cycle to prev completion item, or manually invoke completion
              prev = '<A-[>',
              -- Cycle to next completion item, or manually invoke completion
              next = '<A-]>',
              dismiss = '<A-e>',
          },
      },
  }
end

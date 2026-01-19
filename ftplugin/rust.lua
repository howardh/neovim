-- require'nvim-treesitter'.install { 'rust' }:wait(300000) -- wait max. 5 minutes

vim.treesitter.start()

vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.wo[0][0].foldmethod = 'expr'


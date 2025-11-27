if vim.g.vscode then return end

require('mini.deps').setup(
    {
        path = {
            package = vim.fn.stdpath('data') .. '/site/'
        }
    }
)
MiniDeps.add('neovim/nvim-lspconfig')
MiniDeps.add('mason-org/mason.nvim')
MiniDeps.add('mason-org/mason-lspconfig.nvim')
require('mason').setup()
require('mason-lspconfig').setup()
require('mini.completion').setup()
-- 可用最简 但还需配置completion的习惯




MiniDeps.add('neovim/nvim-lspconfig')
MiniDeps.add('mason-org/mason.nvim')
MiniDeps.add('mason-org/mason-lspconfig.nvim')
require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = { 'vimls', 'lua_ls' },
})

vim.lsp.inlay_hint.enable(true)
vim.keymap.set('n', '<Leader>r', vim.lsp.buf.rename)
vim.keymap.set({'n','x'}, '<Leader>l', vim.lsp.buf.format)

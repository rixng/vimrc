MiniDeps.add({
    source = 'nvim-treesitter/nvim-treesitter',
    checkout = 'main',
    hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
})
-- 将git-https转为git-ssh https://github.com/who/what => git@github.com:who/what
for _, config in pairs(require('nvim-treesitter.parsers')) do
    if config.install_info ~= nil and config.install_info ~= nil then
        config.install_info.url = config.install_info.url:gsub(
            "^https://([^:/]+)/",
            "git@%1:"
        )
    end
end

vim.api.nvim_create_autocmd("FileType", {
    callback = function()
      pcall(vim.treesitter.start)
      vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.wo[0][0].foldmethod = 'expr'
      vim.cmd('normal! zR')
    end,
})

MiniDeps.add({
    source = 'nvim-treesitter/nvim-treesitter-textobjects',
    checkout = 'main',
})
require('nvim-treesitter-textobjects').setup({
    select = {
        lookahead = true,
    }
})

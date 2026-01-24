if vim.g.vscode then
    return
end

require('mini.deps').setup(
    {
        path = {
            package = vim.g.vimdir .. '/mini-deps'
        }
    }
)
-- MiniUpdate 更新 mini.nvim 和 mini.deps 插件
vim.api.nvim_create_user_command('MiniUpdate', function()
    vim.cmd('PlugUpdate mini.nvim')
    MiniDeps.update()
end, { bang = true})

require('mini.keymap').setup()

require('mini-plugins/treesitter')
require('mini-plugins/lsp-config')
require('mini-plugins/completion')

require('mini.starter').setup()




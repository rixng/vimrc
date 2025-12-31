---@type LazySpec
return {
    {
        'Mofiqul/vscode.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            local colors = require('vscode.colors').get_colors()
            require('vscode').setup({
                -- Enable transparent background
                transparent = true,
                -- Enable italic comment
                italic_comments = true,
                -- Enable italic inlay type hints
                italic_inlayhints = true,
                -- Underline `@markup.link.*` variants
                underline_links = true,
                -- Disable nvim-tree background color
                disable_nvimtree_bg = true,
                -- Apply theme colors to terminal
                terminal_colors = true,
            })
            local load = require('vscode').load
            require('vscode').load = function(...)
                load(...)
                vim.api.nvim_set_hl(0, 'TreesitterContext', { bg = vim.o.background == 'dark' and '#303030' or '#FFFFFF'})
            end
        end,
    },
}

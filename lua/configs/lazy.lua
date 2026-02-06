-- Bootstrap lazy.nvim
require("lazy").setup({
    root = vim.g.vimdir .. '/lazy',
    spec = {
        { import = 'lazy-plugins', cond = not vim.g.vscode },
        { import = 'lazy-plugins/languages', cond = not vim.g.vscode },
        { import = 'lazy-plugins/vscode', cond = vim.g.vscode },
    },
    git = {
        url_format = vim.g.plug_url_format,
    },
    change_detection = {
        enabled = true,
        notify = false,
    },
    performance = {
        reset_packpath = false,
        rtp = {
            -- 不重置runtimepath, 与plugin vim-plug共用
            reset = false,
        },
    },
    readme = {
        enabled = true,
    },
})

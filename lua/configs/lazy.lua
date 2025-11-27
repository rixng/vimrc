if vim.g.vscode then
    return
end
-- Bootstrap lazy.nvim
require("lazy").setup({
    spec = {
        { import = 'plugins' },
        { import = 'plugins/languages' },
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

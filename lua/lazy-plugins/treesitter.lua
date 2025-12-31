---@type LazySpec
return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate', -- 需要安装c语言环境
        version = '*',
        event = 'VeryLazy',
        opts = {
            ensure_installed = { 'vim', 'regex', 'lua', 'bash', 'markdown', 'markdown_inline', },
            auto_install = true,
            -- 高亮
            highlight = {
                enable = true,
                disable = function(_, buf) -- 高亮100KB以内的文件
                    local max_filesize = 100 * 1024
                    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end,
                additional_vim_regex_highlighting = false,
            },
            -- 范围选取
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection    = '<C-S>',
                    node_incremental  = '<C-S>',
                    node_decremental  = '<C-S-S>',
                    scope_incremental = '<C-A-S>',
                },
            },
            -- 文本对象
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ['af'] = '@function.outer',
                        ['if'] = '@function.inner',
                        ['ac'] = '@class.outer',
                        ['ic'] = '@class.inner',
                        ['as'] = { query = '@local.scope', query_group = 'locals' },
                        ['is'] = { query = '@local.scope', query_group = 'locals' },
                        ['aa'] = '@parameter.outer',
                        ['ia'] = '@parameter.inner',
                    },
                    selection_modes = {
                        ['@class.outer'] = 'V', -- linewise
                    },
                    include_surrounding_whitespace = true,
                },
            },
            -- % 匹配
            matchup = {
                enable = true,
            },
        },
        init = function()
        end,
        config = function(_, opts)
            require 'nvim-treesitter.install'.prefer_git = true
            -- 将git地址从https改为ssh 下载失败尝试关闭VPN
            -- https://github.com/who/what => git@github.com:who/what
            for _, config in pairs(require('nvim-treesitter.parsers').get_parser_configs()) do
                config.install_info.url = config.install_info.url:gsub(
                    'https://github.com/',
                    'git@github.com:'
                )
            end
            require 'nvim-treesitter.configs'.setup(opts)
            -- 使用git下载
        end,
    },
    {
        -- 文本对象
        'nvim-treesitter/nvim-treesitter-textobjects',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        version = '*',
        event = 'VeryLazy',
    },
    {
        -- 显示代码上下文
        'nvim-treesitter/nvim-treesitter-context',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        version = '*',
        event = 'VeryLazy',
        config = true,
    },
    {
        -- 自动Tag
        'windwp/nvim-ts-autotag',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        version = '*',
        event = 'VeryLazy',
        config = true,
    },
    {
        -- % 匹配
        'andymass/vim-matchup',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        event = 'VeryLazy',
        config = function()
            vim.keymap.set({ 'n', 'x', 'o' }, 'M', '%', { remap = true })
        end,
    },
    {
        -- 注释
        'JoosepAlviste/nvim-ts-context-commentstring',
    },
    {
        -- 自动括号
        'windwp/nvim-autopairs',
        version = '*',
        event = 'VeryLazy',
        opts = {
            modes = { insert = true, command = true, terminal = false },
            check_ts = true,
            skip_ts = { 'string' },
            skip_unbalanced = true,
        },
    },
}

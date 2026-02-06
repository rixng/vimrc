return {
    {
        import = 'lazy-plugins/treesitter'
    },
    {
        "szb000801/smart-input-pro.nvim",
        config = function(_, opts)
            require("smart-input-pro").setup()
        end,
    },
    {
        "gbprod/yanky.nvim",
        opts = {
        },
    }
}

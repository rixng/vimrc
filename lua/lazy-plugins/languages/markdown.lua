return {
    {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
            heading = {
                position = 'inline',
            },
            -- 执行渲染的模式
            render_modes = { 'n', 'c', 't' },
            anti_conceal = {
                -- true:  当前行实时显示源码
                -- false: 当前行保持渲染
                enabled = false,
            },
        },
    },
}

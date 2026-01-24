-- 初始不允许使用输入法
vim.g.neovide_input_ime = false

local ime_input = vim.api.nvim_create_augroup('ime_input', { clear = true })

-- 插入模式允许使用输入法
vim.api.nvim_create_autocmd('InsertEnter', {
    group = ime_input,
    pattern = "*",
    callback = function() vim.g.neovide_input_ime = true end,
})
vim.api.nvim_create_autocmd('InsertLeave', {
    group = ime_input,
    pattern = "*",
    callback = function() vim.g.neovide_input_ime = false end,
})
-- 命令行模式
vim.api.nvim_create_autocmd('CmdlineLeave', {
    group = ime_input,
    callback = function() vim.g.neovide_input_ime = false end,
})
-- 允许通过<C-Space>开启输入法
vim.keymap.set({ 'v', 'n', 'i', 'c', 't' }, '<C-Space>', function() vim.g.neovide_input_ime = true end, { noremap = true })

vim.g.neovide_position_animation_length = 0
vim.g.neovide_cursor_animation_length = 0.00
vim.g.neovide_cursor_trail_size = 0
vim.g.neovide_cursor_animate_in_insert_mode = false
vim.g.neovide_cursor_animate_command_line = false
vim.g.neovide_scroll_animation_far_lines = 0
vim.g.neovide_scroll_animation_length = 0.00
vim.g.neovide_cursor_smooth_blink = false

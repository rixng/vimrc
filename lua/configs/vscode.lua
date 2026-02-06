local action = require('vscode').action
vim.api.nvim_create_user_command('Action', function(opt)
    action(opt.args)
end, { bang = true, nargs = 1 })

vim.keymap.set({'n','x'}, '<Leader><Leader>', function() action('workbench.action.showCommands') end)

vim.keymap.set('n', '<Leader>ef', function() action('workbench.files.action.showActiveFileInExplorer') end)

vim.keymap.set('n', '<Leader>ff', function() action('workbench.action.quickOpen') end)
vim.keymap.set('n', '<Leader>fg', function() action('workbench.action.quickTextSearch') end)

vim.keymap.set('n', '<F1>', function() action('editor.action.marker.nextInFiles') end)
vim.keymap.set('n', '<S-F1>', function() action('editor.action.marker.prevInFiles') end)

vim.keymap.set('n', '<Leader>r', vim.lsp.buf.rename)
vim.keymap.set({'n','x'}, '<Leader>l', vim.lsp.buf.format)
vim.keymap.set('n', 'gI', function() action('editor.action.goToImplementation') end)
vim.keymap.set('n', 'gS', function() action('java.action.navigateToSuperImplementation') end)

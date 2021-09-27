vim.g.fzf_preview_window = { 'down:70%', 'ctrl-/' }

vim.api.nvim_set_keymap('n', '<a-o>', ':Files!<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<a-f>', ':Rg!<CR>', { noremap = true, silent = true })

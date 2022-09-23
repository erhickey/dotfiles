vim.g.simpledb_use_default_keybindings = 0

vim.api.nvim_set_keymap('v', '<CR>', ':SimpleDBExecuteSql<CR>', { expr = false, noremap = true });
vim.api.nvim_set_keymap('n', '<leader><CR>', "m':'{,'}SimpleDBExecuteSql<CR>g`'", { expr = false, noremap = true });
vim.api.nvim_set_keymap('i', '<C-B>', "<Esc>m':'{,'}SimpleDBExecuteSql<CR>g`'a", { expr = false, noremap = true });

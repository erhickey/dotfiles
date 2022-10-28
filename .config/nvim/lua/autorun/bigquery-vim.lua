local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<leader><CR>', "m'vap:BQExecute<CR>g`'", opts);

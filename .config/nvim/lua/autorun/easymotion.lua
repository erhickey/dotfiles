vim.g.EasyMotion_do_mapping = 0
vim.g.EasyMotion_smartcase = 1

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<leader>j', ':call EasyMotion#OverwinF(2)<CR>', opts);

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<c-n>', ':bn<CR>', opts);
vim.api.nvim_set_keymap('n', '<c-p>', ':bp<CR>', opts);
vim.api.nvim_set_keymap('n', '<a-x>', ':BCCloseBuffer<CR>', opts);
vim.api.nvim_set_keymap('n', '<a-X>', ':BCForceCloseBuffer<CR>', opts);
vim.api.nvim_set_keymap('n', '<a-o>', ':BCCloseOtherBuffers<CR>', opts);
vim.api.nvim_set_keymap('n', '<a-E>', ':BCReloadBuffers<CR>', opts);

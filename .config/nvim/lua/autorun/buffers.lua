local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<c-n>', ':bn<CR>', opts);
vim.api.nvim_set_keymap('n', '<c-p>', ':bp<CR>', opts);
vim.api.nvim_set_keymap('n', '<c-x>', ':BCCloseBuffer<CR>', opts);
vim.api.nvim_set_keymap('n', '<c-X>', ':BCForceCloseBuffer<CR>', opts);
vim.api.nvim_set_keymap('n', '<a-o>', ':BCCloseOtherBuffers<CR>', opts);
vim.api.nvim_set_keymap('n', '<a-E>', ':BCReloadBuffers<CR>', opts);

vim.api.nvim_set_keymap('n', "<a-'>", ':cn<CR>', opts);
vim.api.nvim_set_keymap('n', '<a-;>', ':cp<CR>', opts);

-- remove quickfix window from buffer list
local au_group_name = 'qf'
vim.api.nvim_create_augroup(au_group_name, { clear = true })
vim.api.nvim_create_autocmd(
  'FileType',
  { command = 'set nobuflisted', group = au_group_name, pattern = { 'qf' } }
)

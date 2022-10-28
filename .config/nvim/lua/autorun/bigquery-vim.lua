local function create_keymaps()
  local opts = { noremap=true, silent=true }
  vim.api.nvim_set_keymap('n', '<leader><CR>', "m'vap:BQExecute<CR>g`'", opts);
end

local au_group_name = 'bigquery_vim_aug'
vim.api.nvim_create_augroup(au_group_name, { clear = true })
vim.api.nvim_create_autocmd(
  'BufEnter',
  { command = 'set syntax=sql', group = au_group_name, pattern = { '*.bq' } }
)
vim.api.nvim_create_autocmd(
  { 'BufReadPost', 'BufNewFile' },
  { callback = create_keymaps, group = au_group_name, pattern = { '*.bq' } }
)

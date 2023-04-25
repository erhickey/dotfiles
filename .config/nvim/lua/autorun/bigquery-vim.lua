local function create_keymaps()
  local wk = require('which-key')
  wk.register({
    ['<cr>'] = { "m'vap:BQExecute<CR>g`'", 'Execute query' }
  }, { prefix = '<leader>' })
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

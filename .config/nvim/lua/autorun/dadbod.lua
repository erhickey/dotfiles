vim.api.nvim_create_user_command(
  'DBExec',
  function(opts)
    vim.api.nvim_command(
      string.format(
        '%s,%sDB %s',
        opts.line1,
        opts.line2,
        string.sub(vim.fn.getline(1), 3)
      )
    )
  end,
  { range = true }
)

local opts = { expr=false, noremap=true, silent=true }
vim.api.nvim_set_keymap('v', '<CR>', ':DBExec<CR>', opts);
vim.api.nvim_set_keymap('n', '<leader><CR>', "m':'{,'}DBExec<CR>g`'", opts);
vim.api.nvim_set_keymap('i', '<C-B>', "<Esc>m':'{,'}DBExec<CR>g`'a", opts);

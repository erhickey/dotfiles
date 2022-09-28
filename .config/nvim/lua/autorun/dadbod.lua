local function dadbod_get_conn_string()
  local url = vim.fn.getline(1)
  return string.sub(url, 3)
end

local function dadbod_get_query(start_line, end_line)
  local query = vim.fn.getline(start_line, end_line)
  return table.concat(query, ' ')
end

function dadbod_execute_query(start_line, end_line)
  vim.api.nvim_command(
    string.format(
      '%s %s %s',
      'DB ',
      dadbod_get_conn_string(),
      dadbod_get_query(start_line, end_line)
    )
  )
end

vim.api.nvim_create_user_command(
  'DadbodExecuteSql',
  function(opts)
    dadbod_execute_query(opts.line1, opts.line2)
  end,
  { range = true }
)

local opts = { expr=false, noremap=true, silent=true }
vim.api.nvim_set_keymap('v', '<CR>', ':DadbodExecuteSql<CR>', opts);
vim.api.nvim_set_keymap('n', '<leader><CR>', "m':'{,'}DadbodExecuteSql<CR>g`'", opts);
vim.api.nvim_set_keymap('i', '<C-B>', "<Esc>m':'{,'}DadbodExecuteSql<CR>g`'a", opts);

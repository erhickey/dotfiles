local row_count_labels = {
  delete = 'Rows Deleted:   ',
  insert = 'Rows Inserted:   ',
  update = 'Rows Updated:   '
}

local function ltrim(s)
  return s:match('^%s*(.*)')
end

local function split_statements(s)
  return s:gmatch('[^;]+')
end

local function strip_special_characters(s)
  return s:gsub("'", ''):gsub('"', ''):gsub('`', '')
end

local function get_conn_string()
  return vim.fn.getline(1):sub(3)
end

local function get_selection(start_line, end_line)
  return table.concat(vim.fn.getline(start_line, end_line), ' ')
end

local function get_statements(start_line, end_line)
  local ss = {}
  for s in split_statements(get_selection(start_line, end_line)) do
    if ltrim(s) ~= '' then
      table.insert(ss, s)
    end
  end
  return ss
end

local function add_statement_verbosity(statement)
  local command = ltrim(statement):sub(0,6):lower()
  local label = row_count_labels[command]

  if label then
    return
      statement .. "; select concat('" .. label .. "', row_count()) as '" ..
      strip_special_characters(statement) .. "';"
  end

  return statement
end

function dadbod_execute_query(start_line, end_line)
  local statements = get_statements(start_line, end_line)

  local ss = {}
  for _, statement in ipairs(statements) do
    table.insert(ss, add_statement_verbosity(statement))
  end

  vim.api.nvim_command(
    string.format(
      '%s %s %s',
      'DB ',
      get_conn_string(),
      table.concat(ss)
    )
  )
end

vim.api.nvim_create_user_command(
  'DBExec',
  function(opts)
    dadbod_execute_query(opts.line1, opts.line2)
  end,
  { range = true }
)

local opts = { expr=false, noremap=true, silent=true }
vim.api.nvim_set_keymap('v', '<CR>', ':DBExec<CR>', opts);
vim.api.nvim_set_keymap('n', '<leader><CR>', "m':'{,'}DBExec<CR>g`'", opts);
vim.api.nvim_set_keymap('i', '<C-B>', "<Esc>m':'{,'}DBExec<CR>g`'a", opts);

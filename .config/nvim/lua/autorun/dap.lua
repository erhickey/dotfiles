local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
  vim.notify('nvim-dap not found')
  return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
  vim.notify('nvim-dap-ui not found')
  return
end

dapui.setup {
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  expand_lines = vim.fn.has "nvim-0.7",
  -- Layouts define sections of the screen to place windows.
  -- The position can be "left", "right", "top" or "bottom".
  -- The size specifies the height/width depending on position. It can be an Int
  -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
  -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
  -- Elements are the elements shown in the layout (in order).
  -- Layouts are opened in order so that earlier layouts take priority in window sizing.
  layouts = {
    {
      elements = {
        -- Elements can be strings or table with id and size keys.
        { id = "scopes", size = 0.25 },
        "breakpoints",
        -- "stacks",
        -- "watches",
      },
      size = 40, -- 40 columns
      position = "right",
    },
    {
      elements = {
        "repl",
        "console",
      },
      size = 0.25, -- 25% of total lines
      position = "bottom",
    },
  },
  floating = {
    max_height = 0.8, -- These can be integers or a float between 0 and 1.
    max_width = 0.8, -- Floats will be treated as percentage of your screen.
    border = "rounded", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
  },
}

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open {}
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close {}
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close {}
end

local wk = require('which-key')
wk.register({
  d = {
    name = 'Debug',
    c = { "<Cmd>lua require'dap'.continue()<CR>", 'Continue' },
    j = { "<Cmd>lua require'dap'.step_over()<CR>", 'Step Over' },
    h = { "<Cmd>lua require'dap'.step_into()<CR>", 'Step Into' },
    k = { "<Cmd>lua require'dap'.step_out()<CR>", 'Step Out' },
    b = { "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", 'Toggle Breakpoint' },
    B = { "<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", 'Breakpoint Condition' },
    r = { "<Cmd>lua require'dap'.repl.open()<CR>", 'Open REPL' },
    l = { "<Cmd>lua require'dap'.run_last()<CR>", 'Run Last' },
    o = { "<Cmd>lua require'dapui'.open()<CR>", 'Open Dapui' },
    x = { "<Cmd>lua require'dapui'.close()<CR>", 'Close Dapui' },
    t = { "<Cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>", 'Run Neotest' },
  },
}, { prefix = '<leader>' })

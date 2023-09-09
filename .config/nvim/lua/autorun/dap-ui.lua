local dap, dapui = require('dap'), require('dapui')
dap.listeners.after.event_initialized['dapui_config'] = function()
  dapui.open()
end

dapui.setup({
  controls = {
    element = 'repl',
    enabled = true,
    icons = {
      disconnect = '',
      pause = '',
      play = '',
      run_last = '',
      step_back = '',
      step_into = '',
      step_out = '',
      step_over = '',
      terminate = ''
    }
  },
  element_mappings = {},
  expand_lines = true,
  floating = {
    border = 'single',
    mappings = {
      close = { 'q', '<Esc>' }
    }
  },
  force_buffers = true,
  icons = {
    collapsed = '',
    current_frame = '',
    expanded = ''
  },
  layouts = {
    {
      elements = {
        {
          id = 'watches',
          size = 0.4
        }, {
          id = 'scopes',
          size = 0.6
        },
      },
      position = 'bottom',
      size = 20
    },
    {
      elements = {
        {
          id = 'breakpoints',
          size = 0.5
        }, {
          id = 'repl',
          size = 0.2
        },
      },
      position = 'right',
      size = 40
    }
  },
  mappings = {
    edit = 'e',
    expand = { '<CR>', '<2-LeftMouse>' },
    open = 'o',
    remove = 'd',
    repl = 'r',
    toggle = 't'
  },
  render = {
    indent = 1,
    max_value_lines = 100
  }
})

local wk = require('which-key')
wk.register({
  d = {
    name = 'Debug',
    u = { "<Cmd>lua require'dapui'.toggle()<CR>", 'Toggle UI' },
    e = { "<Cmd>lua require'dapui'.eval()<CR>", 'Evaluate Expression', mode = 'v' },
  },
}, { prefix = '<leader>' })

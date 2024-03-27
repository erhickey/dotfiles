local adapters = {
  {
    name = 'javascript',
    filename= 'js-debug-dap.tar.gz',
    url = 'https://github.com/microsoft/vscode-js-debug/releases/download/v1.88.0/js-debug-dap-v1.88.0.tar.gz'
  },
}

local adapters_path = vim.fn.stdpath('data')..'/debug-adapters'

for _, adapter in pairs(adapters) do
  local adapter_path = adapters_path..'/'..adapter.name
  local code = os.execute('test -d '..adapter_path)
  if code > 0 then
    local file = adapter_path..'/'..adapter.filename
    os.execute('curl -fLo '..file..' --create-dirs '..adapter.url)
    os.execute('tar -xf '..file..' -C '..adapter_path)
    os.execute('rm '..file)
  end
end

local dap = require('dap')

dap.adapters['pwa-node'] = {
  type = 'server',
  host = 'localhost',
  port = '${port}',
  executable = {
    command = 'node',
    args = {adapters_path..'/javascript/js-debug/src/dapDebugServer.js','${port}'},
  }
}

for _, language in pairs({ 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' }) do
  dap.configurations[language] = {
    {
      type = 'pwa-node',
      request = 'attach',
      name = 'Attach To Debugger',
      address = function() return require('util').prompt('Debugger address', '127.0.0.1') end,
      port = function() return require('util').prompt('Debugger port: ', '9229') end,
      cwd = '${workspaceFolder}',
      continueOnAttach = false,
      sourceMaps = true,
      skipFiles = {
        '<node_internals>/**',
        '**/node_modules/**',
      },
    },
    {
      type = 'pwa-node',
      request = 'attach',
      name = 'Attach To Program',
      processId = require('dap.utils').pick_process,
      cwd = '${workspaceFolder}',
      continueOnAttach = false,
      sourceMaps = true,
      skipFiles = {
        '<node_internals>/**',
        '**/node_modules/**'
      },
    },
    {
      type = 'pwa-node',
      request = 'launch',
      name = 'Launch Current File',
      cwd = '${workspaceFolder}',
      args = {'${file}'},
      sourceMaps = true,
      protocol = 'inspector',
      continueOnAttach = false,
      skipFiles = {
        '<node_internals>/**',
        '**/node_modules/**'
      }
    },
    {
      type = 'pwa-node',
      request = 'launch',
      name = 'Launch Current File With Jest',
      cwd = '${workspaceFolder}',
      runtimeArgs = { '${workspaceFolder}/node_modules/.bin/jest' },
      runtimeExecutable = 'node',
      args = { '${file}', '--coverage', 'false' },
      rootPath = '${workspaceFolder}',
      sourceMaps = true,
      console = 'integratedTerminal',
      internalConsoleOptions = 'neverOpen',
      skipFiles = {
        '<node_internals>/**',
        '**/node_modules/**'
      }
    }
  }
end

dap.adapters.python = {
  type = 'executable',
  command = 'python3',
  args = { '-m', 'debugpy.adapter' }
}

dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = 'Launch Current File',
    program = '${file}',
    console = 'integratedTerminal',
  },
  {
    type = 'python',
    request = 'launch',
    name = 'Pytest Current File',
    module = 'pytest',
    args = { '${file}' },
    console = 'integratedTerminal',
  }
}

local wk = require('which-key')
wk.register({
  d = {
    name = 'Debug',
    c = { "<Cmd>lua require'dap'.continue()<CR>", 'Start/Continue' },
    j = { "<Cmd>lua require'dap'.step_over()<CR>", 'Step Over' },
    h = { "<Cmd>lua require'dap'.step_into()<CR>", 'Step Into' },
    k = { "<Cmd>lua require'dap'.step_out()<CR>", 'Step Out' },
    b = { "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", 'Toggle Breakpoint' },
    B = { "<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", 'Breakpoint Condition' },
    p = { "<Cmd>lua print(vim.inspect(require('dap.breakpoints').get()))<CR>", 'Print Breakpoints' },
    o = { "<Cmd>lua require'dap'.repl.open()<CR>", 'Open REPL' },
    r = { "<Cmd>lua require'dap'.continue()<CR>", 'Run' },
  },
}, { prefix = '<leader>' })

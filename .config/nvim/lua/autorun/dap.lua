local adapters = {
  {
    name = 'javascript',
    filename= 'js-debug-dap.tar.gz',
    url = 'https://github.com/microsoft/vscode-js-debug/releases/download/v1.81.0/js-debug-dap-v1.81.0.tar.gz'
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

for _, language in pairs({ 'typescript', 'javascript' }) do
  dap.configurations[language] = {
    {
      type = 'pwa-node',
      request = 'attach',
      name = 'Attach',
      address = function() return vim.fn.input('Debugger address: ') end,
      port = function() return vim.fn.input('Debugger port: ') end,
      cwd = '${workspaceFolder}',
      localRoot = '${workspaceRoot}/',
      remoteRoot = '${workspaceRoot}/',
      continueOnAttach = true,
      skipFiles = {
        '**/node_modules/**'
      }
    },
  }
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
    p = { "<Cmd>lua print(vim.inspect(require('dap.breakpoints').get()))<CR>", 'Print Breakpoints' },
    o = { "<Cmd>lua require'dap'.repl.open()<CR>", 'Open REPL' },
    r = { "<Cmd>lua require'dap'.continue()<CR>", 'Run' },
  },
}, { prefix = '<leader>' })

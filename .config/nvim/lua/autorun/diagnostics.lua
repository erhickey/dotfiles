local severities = {
  Error = {
    icon = '',
    fg = '#cc241d'
  },
  Warn = {
    icon = '',
    fg = '#d65d0e'
  },
  Hint = {
    icon = '',
    fg = '#458588'
  },
  Info = {
    icon = '',
    fg = '#a89984'
  }
}

for type, config in pairs(severities) do
  vim.cmd('highlight clear Diagnostic' .. type)
  vim.cmd('highlight Diagnostic' .. type .. ' guifg=' .. config.fg)

  vim.fn.sign_define(
    'DiagnosticSign' .. type,
    {
      text = config.icon,
      texthl = 'Diagnostic' .. type,
      numhl = 'Diagnostic' .. type,
    })
end

vim.diagnostic.config({
  severity_sort = true,
  float = {
    border = 'rounded',
    scope = 'cursor',
    severity_sort = true,
    source = true,
  },
})

require('diagline-nvim').setup()

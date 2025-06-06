local severities = {
  [vim.diagnostic.severity.ERROR] = {
    hlname = 'Error',
    icon = '',
    fg = '#cc241d'
  },
  [vim.diagnostic.severity.WARN] = {
    hlname = 'Warn',
    icon = '',
    fg = '#d65d0e'
  },
  [vim.diagnostic.severity.HINT] = {
    hlname = 'Hint',
    icon = '',
    fg = '#458588'
  },
  [vim.diagnostic.severity.INFO] = {
    hlname = 'Info',
    icon = '',
    fg = '#a89984'
  }
}

local signs = {
  text = {},
  numhl = {},
}

for severity, config in pairs(severities) do
  vim.cmd('highlight Diagnostic' .. config.hlname .. ' guifg=' .. config.fg)

  signs.text[severity] = config.icon
  signs.numhl[severity] = 'Diagnostic' .. config.hlname
end

vim.diagnostic.config({
  signs = signs,
  severity_sort = true,
  float = {
    border = 'rounded',
    scope = 'cursor',
    severity_sort = true,
    source = true,
  },
})

require('diagline-nvim').setup({ signs = signs })

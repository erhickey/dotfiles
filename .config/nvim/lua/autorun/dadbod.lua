-- default db config:
--  :help dadbod-variables

local wk = require('which-key')

wk.register({
  ['<cr>'] = { "m'vap:DB<CR>g`'", 'Execute query' },
}, { prefix = '<leader>' })

wk.register({
  ['<cr>'] = { ":DB<CR>", 'Execute query' },
}, { prefix = '<leader>', mode = 'v' })

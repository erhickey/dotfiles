vim.g.fzf_preview_window = { 'down:70%', 'ctrl-/' }

-- [Buffers] Jump to the existing window if possible
vim.g.fzf_buffers_jump = 1

local wk = require('which-key')

wk.register({
  o = { ':Files!<CR>', 'Open file(s)' },
  b = { ':Buffers<CR>', 'Open buffer' },
  f = {
    name = 'Fuzzy Search',
    f = { ':Rg!<CR>', 'Search project (ripgrep)' },
    a = { ':BLines!<CR>', 'Search open buffers' },
    j = { ':Jumps!<CR>', 'Search jumps' },
    m = { ':Marks!<CR>', 'Search marks' },
    w = { ':Rg! <C-R><C-W><CR>', 'Search for current word' },
  },
}, { prefix = '<leader>' })

wk.register({
  o = { ':Files!<CR>', 'Open file(s)' },
  b = { ':Buffers<CR>', 'Open buffer' },
  f = {
    name = 'Fuzzy Search',
    f = { 'y:Rg! <C-R>0<CR>', 'Search for current selection' },
  },
}, { prefix = '<leader>', mode = 'v' })

-- modify fzf.vim Rg command to avoid searching file names
vim.api.nvim_command("command! -bang -nargs=* Rg call fzf#vim#grep('rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)")

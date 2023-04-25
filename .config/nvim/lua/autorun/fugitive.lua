local wk = require('which-key')

wk.register({
  g = {
    name = 'Fugitive',
    d = { ':Gdiffsplit<CR>', 'Diff with staged version' },
    x = { ':GDelete<CR>', 'git rm current buffer' },
    b = { ':Git blame<CR>', 'git blame' },
    f = { ':Git diff<CR>', 'git diff' },
    m = { ':Git mergetool<CR>', 'Load merge changes in quickfix list' },
    F = { ':Git difftool<CR>', 'Load diff changes in quickfix list' },
    g = { ':Git<CR>', 'Summary' },
    r = { function()
            print(":GRename git mv on current file, also updates buffer name. filename relative to current file's directory.")
          end, 'Print git move help'
    },
  }
}, { prefix = '<leader>' })

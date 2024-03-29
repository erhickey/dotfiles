require('gitsigns').setup({
  _signs_staged_enable = true,
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '-', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  signcolumn = true,
  numhl      = true,
  linehl     = false,
  word_diff  = false,
  watch_gitdir = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm = {
    enable = false
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns
    local wk = require('which-key')

    wk.register({
      ['['] = {
        c = { function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, 'Go to previous hunk' }
      },
      [']'] = {
        c = { function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, 'Go to next hunk' }
      }
    })

    wk.register({
      c = {
        name = 'gitsigns',
        p = { gs.preview_hunk, 'Preview hunk' },
        n = { gs.diffthis, 'Diff hunk' },
        s = { gs.stage_hunk, 'Stage hunk' },
        r = { gs.reset_hunk, 'Reset hunk' },
        u = { gs.undo_stage_hunk, 'Undo stage hunk' },
        S = { gs.stage_buffer, 'Stage buffer' },
        R = { gs.reset_buffer, 'Reset buffer' },
        b = { function() gs.blame_line{full=true} end, 'Blame' },
      }
    }, { prefix = '<leader>', buffer = bufnr })
  end
})

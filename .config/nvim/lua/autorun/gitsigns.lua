require('gitsigns').setup({
  signs = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signs_staged = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signs_staged_enable = true,
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = true,  -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true
  },
  auto_attach = true,
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
    virt_text_priority = 100,
    use_focus = true,
  },
  current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns
    require('which-key').add({
      {
        "[c",
        function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end,
        desc = "Go to previous hunk"
      },
      {
        "]c",
        function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end,
        desc = "Go to next hunk"
      },
      { "<leader>c", buffer = bufnr, group = "gitsigns" },
      { "<leader>cR", gs.reset_buffer, buffer = bufnr, desc = "Reset buffer" },
      { "<leader>cS", gs.stage_buffer, buffer = bufnr, desc = "Stage buffer" },
      { "<leader>cb", function() gs.blame_line{full=true} end, buffer = bufnr, desc = "Blame" },
      { "<leader>cn", gs.diffthis, buffer = bufnr, desc = "Diff hunk" },
      { "<leader>cp", gs.preview_hunk, buffer = bufnr, desc = "Preview hunk" },
      { "<leader>cr", gs.reset_hunk, buffer = bufnr, desc = "Reset hunk" },
      { "<leader>cs", gs.stage_hunk, buffer = bufnr, desc = "Stage hunk" },
      { "<leader>cu", gs.undo_stage_hunk, buffer = bufnr, desc = "Undo stage hunk" },
    })
  end
})

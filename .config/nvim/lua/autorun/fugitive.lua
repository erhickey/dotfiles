require('which-key').add({
  { "<leader>g", group = "Fugitive" },
  { "<leader>gF", ":Git difftool<CR>", desc = "Load diff changes in quickfix list" },
  { "<leader>gb", ":Git blame<CR>", desc = "git blame" },
  { "<leader>gd", ":Gdiffsplit<CR>", desc = "Diff with staged version" },
  { "<leader>gf", ":Git diff<CR>", desc = "git diff" },
  { "<leader>gg", ":Git<CR>", desc = "Summary" },
  { "<leader>gm", ":Git mergetool<CR>", desc = "Load merge changes in quickfix list" },
  {
    "<leader>gr",
    function()
      print(":GRename git mv on current file, also updates buffer name. filename relative to current file's directory.")
    end,
    desc = "Print git move help"
  },
  { "<leader>gx", ":GDelete<CR>", desc = "git rm current buffer" }
})

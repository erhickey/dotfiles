-- default db config:
--  :help dadbod-variables

require('which-key').add({
  { "<leader><cr>", "m'vap:DB<CR>g`'", desc = "Execute query", mode = "n" },
  { "<leader><cr>", ":DB<CR>", desc = "Execute query", mode = "v" }
})

require('claudecode').setup {
  terminal = {
    split_side = "right",
    split_width_percentage = 0.45,
    provider = "native",
  },

  diff_opts = {
    auto_close_on_accept = true,
    vertical_split = true,
  },
}

require('which-key').add({
  { "<leader>a", group = "Claude" },
  { "<leader>ac", ":ClaudeCode<cr>", desc = "Toggle Claude" },
  { "<leader>as", ":ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
})

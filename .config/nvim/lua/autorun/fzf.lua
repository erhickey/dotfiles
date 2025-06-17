vim.g.fzf_preview_window = { 'down:70%', 'ctrl-/' }

-- [Buffers] Jump to the existing window if possible
vim.g.fzf_buffers_jump = 1

-- modify fzf.vim Rg command to avoid searching file names
vim.api.nvim_command("command! -bang -nargs=* Rg call fzf#vim#grep('rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)")

require('which-key').add({
  { "<leader>b", ":Buffers<CR>", desc = "Open buffer" },
  { "<leader>f", group = "Fuzzy Search" },
  { "<leader>fb", ":Lines!<CR>", desc = "Search open buffers" },
  { "<leader>ff", ":Rg!<CR>", desc = "Search project (ripgrep)", mode = "n" },
  { "<leader>fj", ":Jumps!<CR>", desc = "Search jumps" },
  { "<leader>fm", ":Marks!<CR>", desc = "Search marks" },
  { "<leader>fw", ":Rg! <C-R><C-W><CR>", desc = "Search for current word" },
  { "<leader>o", ":Files!<CR>", desc = "Open file(s)" },
  { "<leader>ff", "y:Rg! <C-R>0<CR>", desc = "Search for current selection", mode = "v" },
})

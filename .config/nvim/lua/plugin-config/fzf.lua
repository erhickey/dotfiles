vim.g.fzf_preview_window = { 'down:70%', 'ctrl-/' }

vim.api.nvim_set_keymap('n', '<a-o>', ':Files!<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<a-f>', ':Rg!<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>rg', ':Rg! <C-R><C-W><CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>rg', 'y:Rg! <C-R>0<CR>', { noremap = true, silent = true })

-- modify fzf.vim Rg command to avoid searching file names
vim.api.nvim_command("command! -bang -nargs=* Rg call fzf#vim#grep('rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)")

vim.g.fzf_preview_window = { 'down:70%', 'ctrl-/' }

-- [Buffers] Jump to the existing window if possible
vim.g.fzf_buffers_jump = 1

local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap('n', '<leader>o', ':Files!<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>f', ':Rg!<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>a', ':BLines!<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>m', ':Marks!<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>rg', ':Rg! <C-R><C-W><CR>', opts)
vim.api.nvim_set_keymap('v', '<leader>rg', 'y:Rg! <C-R>0<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>b', ':Buffers<CR>', opts)

-- modify fzf.vim Rg command to avoid searching file names
vim.api.nvim_command("command! -bang -nargs=* Rg call fzf#vim#grep('rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)")

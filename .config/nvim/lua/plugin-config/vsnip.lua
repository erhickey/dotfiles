vim.api.nvim_set_keymap('i', '<C-l>', 'vsnip#available(1) ? "<Plug>(vsnip-expand-or-jump)" : "<C-l>"', { expr = true, noremap = false });

vim.g['vsnip_snippet_dir'] = '~/.config/nvim/snippets'

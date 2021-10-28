require('bufferline').setup{
  options = {
    numbers = 'buffer_id',
    diagnostics = 'nvim_lsp',
    show_buffer_close_icons = false,
    show_close_icon = false,
    separator_style = 'slant',
    enforce_regular_tabs = false,
    always_show_bufferline = true
  }
}

vim.api.nvim_set_keymap('n', '<a-n>', ':BufferLineCycleNext<CR>', { noremap = true, silent = true });
vim.api.nvim_set_keymap('n', '<a-p>', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true });
vim.api.nvim_set_keymap('n', '<a-x>', ':bd<CR>', { noremap = true, silent = true });

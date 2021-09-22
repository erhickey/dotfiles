require("bufferline").setup{
  options = {
    numbers = "buffer_id",
    diagnostics = "nvim_lsp",
    show_buffer_close_icons = false,
    show_close_icon = false,
    always_show_bufferline = true
  }
}

vim.api.nvim_set_keymap('n', 'bn', ':BufferLineCycleNext<CR>', { noremap = true, silent = true });
vim.api.nvim_set_keymap('n', 'bp', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true });

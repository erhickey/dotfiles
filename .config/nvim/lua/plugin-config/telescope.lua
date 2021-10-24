require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ['<C-h>'] = 'which_key'
      }
    },
    layout_strategy = 'vertical',
    layout_config = {
      vertical = { width = 0.9 },
      preview_height = 0.6,
    },
  },
}

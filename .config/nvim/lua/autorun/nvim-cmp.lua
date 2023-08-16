local cmp = require('cmp')

cmp.setup{
  snippet = {
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body)
    end
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<Tab>'] = cmp.mapping.select_next_item({behavior=cmp.SelectBehavior.Insert}),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
  }, {
    { name = 'buffer' },
    { name = 'path' },
  }),
}

-- Use buffer source for `/` and `?`
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

local kind_icons = {
  Text = "",
  Method = "󰆧",
  Function = "󰊕",
  Constructor = "",
  Field = "󰇽",
  Variable = "󰂡",
  Class = "󰠱",
  Interface = "",
  Module = "",
  Property = "󰜢",
  Unit = "",
  Value = "󰎠",
  Enum = "",
  Keyword = "󰌋",
  Snippet = "",
  Color = "󰏘",
  File = "󰈙",
  Reference = "",
  Folder = "󰉋",
  EnumMember = "",
  Constant = "󰏿",
  Struct = "",
  Event = "",
  Operator = "󰆕",
  TypeParameter = "󰅲",
}

local cmp = require('cmp')

cmp.setup{
  enabled = function()
    local buftype = vim.bo.buftype
    if buftype == 'prompt' or buftype == 'nofile' then
      return false
    end
    return true
  end,
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
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
      vim_item.menu = ({
        buffer = "[Buffer]",
        path = "[Path]",
        nvim_lsp = "[LSP]",
        vsnip = "[vsnip]",
      })[entry.source.name]
      return vim_item
    end
  },
}

-- Use buffer source for `/` and `?`
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- gray
vim.cmd('highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080')
-- blue
vim.cmd('highlight! CmpItemAbbrMatch guibg=NONE guifg=#268bd2')
vim.cmd('highlight! link CmpItemAbbrMatchFuzzy CmpItemAbbrMatch')
-- light blue
vim.cmd('highlight! CmpItemKindVariable guibg=NONE guifg=#839496')
vim.cmd('highlight! link CmpItemKindInterface CmpItemKindVariable')
vim.cmd('highlight! link CmpItemKindText CmpItemKindVariable')
-- pink
vim.cmd('highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0')
vim.cmd('highlight! link CmpItemKindMethod CmpItemKindFunction')
-- white
vim.cmd('highlight! CmpItemKindKeyword guibg=NONE guifg=#cecece')
vim.cmd('highlight! link CmpItemKindProperty CmpItemKindKeyword')
vim.cmd('highlight! link CmpItemKindUnit CmpItemKindKeyword')

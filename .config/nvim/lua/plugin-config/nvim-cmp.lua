local cmp = require'cmp'

cmp.setup({
    sources = {
      { name = 'nvim_lsp' },
      { name = 'buffer' },
      { name = 'path' },
    },
    mapping = {
      ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
    },
    formatting = {
      format = function(entry, vim_item)
        vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind

        vim_item.menu = ({
          buffer = "[Buffer]",
          nvim_lsp = "[LSP]",
        })[entry.source.name]
        return vim_item
      end,
    },
    -- required for nvim-cmp to work without snippet engine
    snippet = {
      expand = function(args)
        local _, lnum, col, _ = unpack(vim.fn.getpos("."))
        local ltext = vim.api.nvim_buf_get_lines(0, lnum - 1, lnum, true)[1]
        if args.body:match('\n') ~= nil then
          local indent = string.match(ltext, '^%s*')
          local lines = vim.split(args.body, '\n', true)
          lines[1] = (string.match(ltext, '%S.*') or '')..lines[1]
          if indent ~= '' then
            for i, line in ipairs(lines) do
                lines[i] = indent..line
            end
          end
          vim.api.nvim_buf_set_lines(0, lnum - 1, lnum, true, lines)
        else
          local line = ltext:sub(1, col-1) .. args.body .. ltext:sub(col)
          vim.api.nvim_buf_set_lines(0, lnum - 1, lnum, true, {line})
        end
        vim.api.nvim_win_set_cursor(0, {lnum, col+#args.body})
      end
    },
})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Mappings.
  local opts = { noremap=true, silent=true }

  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)

  buf_set_keymap('n', '<leader>gw', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)
  buf_set_keymap('n', '<leader>gW', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)

  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)

  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)

  buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  buf_set_keymap('v', '<leader>f', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)

  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- npm install -g @angular/language-server
-- requires @angular/language-service development dependency in project
require'lspconfig'.angularls.setup{
  capabilities = capabilities,
  on_attach = on_attach,
}

-- https://github.com/haskell/haskell-language-server
require'lspconfig'.hls.setup{
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    haskell = {
      hLintOn = true,
      maxNumberOfProblems = 30,
      formatOnImportOn = true,
      formattingProvider = 'brittany'
    }
  }
}

-- npm install -g vscode-langservers-extracted
require'lspconfig'.jsonls.setup{
  capabilities = capabilities,
  on_attach = on_attach,
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line('$'),0})
      end
    }
  }
}

-- npm install -g pyright
require'lspconfig'.pyright.setup{
  capabilities = capabilities,
  on_attach = on_attach,
}

-- npm install -g typescript typescript-language-server
require'lspconfig'.tsserver.setup{
  capabilities = capabilities,
  on_attach = on_attach,
}

-- npm install -g vls
require'lspconfig'.vuels.setup{
  capabilities = capabilities,
  on_attach = on_attach,
  init_options = {
    config = {
      vetur = {
        ignoreProjectWarning = true,
      },
    },
  },
}

-- npm install -g diagnostic-languageserver
require'lspconfig'.diagnosticls.setup{
  filetypes = {
    'javascript',
    'typescript',
    'vue'
  },
  init_options = {
    filetypes = {
      javascript = 'eslint',
      typescript = 'eslint',
    },
    linters = {
      -- npm install -g eslint_d
      eslint = {
        sourceName = 'eslint',
        command = 'eslint_d',
        rootPatterns = { 'node_modules' },
        debounce = 100,
        args = {
          '--cache',
          '--stdin',
          '--stdin-filename',
          '%filepath',
          '--format',
          'json',
        },
        parseJson = {
          errorsRoot = '[0].messages',
          line = 'line',
          column = 'column',
          endLine = 'endLine',
          endColumn = 'endColumn',
          message = '${message} [${ruleId}]',
          security = 'severity',
        },
        securities = {
          [2] = 'error',
          [1] = 'warning',
        }
      }
    }
  }
}

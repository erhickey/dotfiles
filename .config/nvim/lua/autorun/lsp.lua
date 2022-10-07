local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local bufopts = { noremap=true, silent=true, buffer=bufnr }

  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)

  vim.keymap.set('n', '<leader>gW', vim.lsp.buf.document_symbol, bufopts)
  vim.keymap.set('n', '<leader>gw', vim.lsp.buf.workspace_symbol, bufopts)

  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)

  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('v', '<leader>ca', vim.lsp.buf.range_code_action, bufopts)

  vim.keymap.set('n', '<A-f>', vim.lsp.buf.formatting, bufopts)
  vim.keymap.set('v', '<A-f>', vim.lsp.buf.range_formatting, bufopts)

  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)

  vim.keymap.set('n', '<leader>cl', vim.lsp.codelens.run, bufopts)
end

local on_attach_with_codelens_refresh = function(client, bufnr)
  on_attach(client, bufnr)
  -- this is buggy when multiple language servers are attached to the same buffer
  vim.api.nvim_command('autocmd BufReadPost,CursorMoved,InsertLeave <buffer> lua vim.lsp.codelens.refresh()')
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local lsp_flags = {
  debounce_text_changes = 150,
}

local lspconfig = require('lspconfig')

-- npm install -g @angular/language-server
-- requires @angular/language-service development dependency in project
lspconfig.angularls.setup{
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags,
}

-- https://github.com/haskell/haskell-language-server
lspconfig.hls.setup{
  capabilities = capabilities,
  on_attach = on_attach_with_codelens_refresh,
  flags = lsp_flags,
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
lspconfig.jsonls.setup{
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags,
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line('$'),0})
      end
    }
  }
}

-- install lua-language-server via package manager
lspconfig.sumneko_lua.setup{
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = {'vim'},
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

-- npm install -g pyright
lspconfig.pyright.setup{
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags,
}

-- https://github.com/lighttiger2505/sqls/releases
lspconfig.sqls.setup{
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags,
}

-- npm install -g typescript typescript-language-server
lspconfig.tsserver.setup{
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags,
}

-- npm install -g vls
lspconfig.vuels.setup{
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags,
  init_options = {
    config = {
      vetur = {
        ignoreProjectWarning = true,
      },
    },
  },
}

-- npm install -g @volar/vue-language-server
lspconfig.volar.setup{
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags,
  filetypes = {
    'typescript',
    'javascript',
    'vue'
  },
  init_options = {
    typescript = {
      serverPath = '/Users/eddie/repositories/clearing-app/node_modules/typescript/lib/tsserverlibrary.js'
    }
  },
}

-- npm install -g diagnostic-languageserver
lspconfig.diagnosticls.setup{
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags,
  filetypes = {
    'javascript',
    'typescript',
    'vue',
    'sh',
    'python',
  },
  init_options = {
    filetypes = {
      javascript = 'eslint',
      typescript = 'eslint',
      vue = 'eslint',
      sh = 'shellcheck',
      python = 'mypy',
      python = 'flake8',
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
          endLine = 'endLine',
          column = 'column',
          endColumn = 'endColumn',
          security = 'severity',
          message = '${message} [${ruleId}]',
        },
        securities = {
          [2] = 'error',
          [1] = 'warning',
        }
      },

      -- install via package manager
      shellcheck = {
        sourceName = 'shellcheck',
        command = 'shellcheck',
        debounce = 100,
        args = { '--format', 'json1', '-' },
        parseJson = {
          errorsRoot= 'comments',
          sourceName= 'file',
          line = 'line',
          endLine = 'endLine',
          column = 'column',
          endColumn = 'endColumn',
          security = 'level',
          message = '${message} [${code}] [${fix}]'
        },
        securities = {
          error = 'error',
          warning = 'warning',
          note = 'info',
          style = 'hint',
        }
      },

      -- python3 -m pip install -U mypy
      mypy = {
        sourceName = 'mypy',
        command = 'mypy',
        debounce = 100,
        args = {
          '--follow-imports=silent',
          '--hide-error-codes',
          '--hide-error-context',
          '--no-color-output',
          '--no-error-summary',
          '--no-pretty',
          '--show-column-numbers',
          '%file',
        },
        rootPatterns = {
          'mypy.ini',
          '.mypy.ini',
          'pyproject.toml',
          'setup.cfg'
        },
        formatPattern = {
          '^.*:(\\d+?):(\\d+?): ([a-z]+?): (.*)$',
          {
            line = 1,
            column = 2,
            security = 3,
            message = 4,
          },
        },
        securities = {
          error = 'error',
        }
      },

      -- python3 -m pip install -U flake8
      flake8 = {
        sourceName = 'flake8',
        command = 'flake8',
        debounce = 100,
        args = {
          '--format=%(row)d,%(col)d,%(code).1s,%(code)s: %(text)s',
          '-',
        },
        rootPatterns = {
          '.flake8',
          'setup.cfg',
          'tox.ini'
        },
        offsetLine = 0,
        offsetColumn = 0,
        formatLines = 1,
        formatPattern = {
          '(\\d+),(\\d+),([A-Z]),(.*)(\\r|\\n)*$',
          {
            line = 1,
            column = 2,
            security = 3,
            message = 4,
          },
        },
        securities = {
          W = 'warning',
          E = 'error',
          F = 'error',
          C = 'error',
          N = 'error',
        }
      },

    }
  }
}

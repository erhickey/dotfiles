require('mason').setup()

local packages = {
  'angular-language-server',    -- npm install -g @angular/language-server
  'diagnostic-languageserver',  -- npm install -g diagnostic-languageserver
  'eslint-lsp',                 -- npm install -g eslint_d
  'flake8',                     -- python -m pip install -U flake8
  'haskell-language-server',    -- https://github.com/haskell/haskell-language-server
  'json-lsp',                   -- npm install -g vscode-langservers-extracted
  'lua-language-server',        -- install via package manager
  'mypy',                       -- python -m pip install -U mypy
  'pyright',                    -- npm install -g pyright
  'shellcheck',                 -- install via package manager
  'sqls',                       -- https://github.com/lighttiger2505/sqls/releases
  'typescript-language-server', -- npm install -g typescript typescript-language-server
  'vue-language-server',        -- npm install -g @volar/vue-language-server
  'vetur-vls',                  -- npm install -g vls
}

local function install_lsp_clients()
  local mr = require('mason-registry')
  for _, p in pairs(packages) do
    local package = mr.get_package(p)
    if not package:is_installed() then
      package:install()
    end
  end
end

install_lsp_clients()

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

local on_attach = function(_, bufnr)
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

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local lsp_flags = {
  debounce_text_changes = 150,
}

local lspconfig = require('lspconfig')

lspconfig.angularls.setup{
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags,
}

lspconfig.eslint.setup{
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags,
}

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

lspconfig.pyright.setup{
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags,
}

lspconfig.sqls.setup{
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    on_attach()
    local sqls_km_opts = { expr=false, noremap=true, silent=true }
    vim.api.nvim_set_keymap('n', '<leader><CR>', "m'vap:SqlsExecuteQuery<CR>g`'", sqls_km_opts);
    require('sqls').on_attach(client, bufnr)
  end,
  flags = lsp_flags,
}

lspconfig.tsserver.setup{
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags,
}

lspconfig.volar.setup{
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags,
  init_options = {
    typescript = {
      tsdk = os.getenv('HOME') .. '/.config/typescript_lib/' -- link, must be created
    }
  },
}

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

lspconfig.diagnosticls.setup{
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags,
  filetypes = {
    'sh',
    'python',
  },
  init_options = {
    filetypes = {
      sh = 'shellcheck',
      python = 'flake8',
    },
    formatFiletypes = {
      python = 'yapf',
    },
    linters = {
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

      -- too slow, not using it
      mypy = {
        sourceName = 'mypy',
        command = 'mypy',
        debounce = 100,
        args = {
          '--show-error-context',
          '--show-column-numbers',
          '--show-error-codes',
          '--no-color-output',
          '--no-error-summary',
          '%file',
        },
        rootPatterns = {
          'mypy.ini',
          '.mypy.ini',
          'pyproject.toml',
          'setup.cfg'
        },
        offsetLine = 0,
        offsetColumn = 0,
        formatLines = 1,
        formatPattern = {
          [[.*:(\d+):(\d+): (\w*): (.*)(\r|\n)*$]],
          {
            line = 1,
            column = 2,
            security = 3,
            message = {
              '[mypy] ',
              4
            }
          },
        },
      },

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

    },
    formatters = {
      yapf = {
        sourceName = 'yapf',
        command = 'yapf',
        rootPatterns = {
          'requirements.txt',
          '.style.yapf',
          'setup.cfg',
          'pyproject.toml',
          '.git',
        },
      }
    }
  }
}

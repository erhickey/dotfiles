require('mason').setup()

local packages = {
  -- 'angular-language-server',    -- npm install -g @angular/language-server@[matching major version]
  -- 'clojure-lsp',                -- install via package manager
  'diagnostic-languageserver',  -- npm install -g diagnostic-languageserver
  'eslint-lsp',                 -- npm install -g eslint_d
  'flake8',                     -- python -m pip install -U flake8                        (requires venv)
  -- 'haskell-language-server',    -- https://github.com/haskell/haskell-language-server  (install w/nix instead)
  'json-lsp',                   -- npm install -g vscode-langservers-extracted
  -- 'lua-language-server',        -- install via package manager
  'mypy',                       -- python -m pip install -U mypy                          (requires venv)
  -- 'nil'                      -- nix ls, install via nix
  'prettierd',                  -- npm install -g @fsouza/prettierd
  'pyright',                    -- npm install -g pyright
  'ruff-lsp',                   -- pip install ruff-lsp                                   (requires venv)
  -- 'rust-analyzer',           --                                                        (install w/ nix instead)
  'shellcheck',                 -- install via package manager
  'typescript-language-server', -- npm install -g typescript typescript-language-server
  'vue-language-server',        -- npm install -g @volar/vue-language-server
}

local function install_lsp_clients()
  local mr = require('mason-registry')
  for _, p in pairs(packages) do
    mr.refresh(function() -- avoid errors due to registry not being downloaded yet
      local package = mr.get_package(p)
      if not package:is_installed() then
        package:install()
      end
    end)
  end
end

install_lsp_clients()

local wk = require('which-key')
wk.register({
  e = { vim.diagnostic.open_float, 'Open diagnostic float' },
  q = { vim.diagnostic.setloclist, 'Open diagnostics in quickfix list' },
}, { prefix = '<leader>' })

wk.register({
  ['['] = {
    d = { vim.diagnostic.goto_prev, 'Go to previous error' }
  },
  [']'] = {
    d = { vim.diagnostic.goto_next, 'Go to next error' }
  }
})

local on_attach = function(_, bufnr)
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)

  wk.register({
    g = {
      d = { vim.lsp.buf.definition, 'Go to symbol definition' },
    },
  }, { buffer = bufnr })

  wk.register({
    l = {
      name = 'LSP',
      g = {
        name = 'Symbols',
        d = { vim.lsp.buf.definition, 'Go to symbol definition' },
        D = { vim.lsp.buf.declaration, 'Go to symbol declaration' },
        r = { vim.lsp.buf.references, 'Show symbol references' },
        n = { vim.lsp.buf.rename, 'Rename all references to symbol' },
        i = { vim.lsp.buf.implementation, 'Show symbol implementations' },
        w = { vim.lsp.buf.document_symbol, 'Show all symbols in current buffer' },
        W = { vim.lsp.buf.workspace_symbol, 'Show all symbols in workspace' },
      },
      k = { vim.lsp.buf.type_definition, 'Show type definition' },
      c = {
        name = 'Actions',
        a = { vim.lsp.buf.code_action, 'Select a code action' },
        l = { vim.lsp.codelens.run, 'Run code lens' },
      },
      w = {
        name = 'Workspaces',
        a = { vim.lsp.buf.add_workspace_folder, 'Add workspace folder' },
        r = { vim.lsp.buf.remove_workspace_folder, 'Remove workspace folder' },
        l = { function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, 'List workspace folders' },
      },
    }
  }, { prefix = '<leader>', buffer = bufnr })
end

local on_attach_format = function(client, bufnr)
  wk.register({
    l = {
      name = 'LSP',
      f = { function() vim.lsp.buf.format({ async = true, id = client.id }) end, 'Format code' },
    }
  }, { prefix = '<leader>', buffer = bufnr })

  wk.register({
    l = {
      name = 'LSP',
      f = { function() vim.lsp.buf.format({ async = true, id = client.id }) end, 'Format code' },
    }
  }, { prefix = '<leader>', buffer = bufnr, mode = 'v' })
end

local on_attach_plus_format = function(client, bufnr)
  on_attach(client, bufnr)
  on_attach_format(client, bufnr)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local lsp_flags = {
  debounce_text_changes = 150,
}

local lspconfig = require('lspconfig')

lspconfig.angularls.setup{
  root_dir = lspconfig.util.root_pattern('node_modules'),
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags,
}

lspconfig.clojure_lsp.setup{
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags,
}

lspconfig.eslint.setup{
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags,
}

local on_attach_haskell = function(client, bufnr)
  on_attach_plus_format(client, bufnr)
  -- this is buggy when multiple language servers are attached to the same buffer
  vim.api.nvim_command('autocmd BufReadPost,CursorMoved,InsertLeave <buffer> lua vim.lsp.codelens.refresh()')
end

lspconfig.hls.setup{
  capabilities = capabilities,
  on_attach = on_attach_haskell,
  flags = lsp_flags,
  settings = {
    haskell = {
      hLintOn = true,
      maxNumberOfProblems = 30,
      formatOnImportOn = true,
      formattingProvider = 'floskell'
    }
  }
}

lspconfig.jsonls.setup{
  capabilities = capabilities,
  on_attach = on_attach_format,
  flags = lsp_flags,
}

lspconfig.lua_ls.setup{
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags,
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
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

lspconfig.nil_ls.setup{
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags,
}

lspconfig.pyright.setup{
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags,
}

lspconfig.ruff_lsp.setup{
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags,
}

lspconfig.rust_analyzer.setup{
  capabilities = capabilities,
  on_attach = on_attach_plus_format,
  flags = lsp_flags,
}

lspconfig.tsserver.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags,
}

local tsc = vim.fn.trim(vim.fn.system('which tsc'))
if not (tsc == nil or tsc == '') then
  local tsdk, _ = tsc:gsub('bin/tsc', 'lib/node_modules/typescript/lib/')
  lspconfig.volar.setup{
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags,
    init_options = {
      typescript = {
        tsdk = tsdk
      }
    },
  }
end

lspconfig.diagnosticls.setup{
  capabilities = capabilities,
  on_attach = on_attach_plus_format,
  flags = lsp_flags,
  filetypes = {
    'sh',
    'python',
    'typescript',
    'javascript',
    'html',
  },
  init_options = {
    filetypes = {
      sh = 'shellcheck',
      -- python = 'flake8',
    },
    formatFiletypes = {
      python = 'yapf',
      typescript = 'prettierd',
      javascript = 'prettierd',
      html = 'prettierd',
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

      -- use ruff instead
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
      },
      prettierd = {
        command = 'prettierd',
        args = { '%filepath' },
        rootPatterns = {
          '.prettierrc',
          '.prettierrc.json',
          '.prettierrc.toml',
          '.prettierrc.json',
          '.prettierrc.yml',
          '.prettierrc.yaml',
          '.prettierrc.json5',
          '.prettierrc.js',
          '.prettierrc.cjs',
          'prettier.config.js',
          'prettier.config.cjs',
        },
      }
    }
  }
}

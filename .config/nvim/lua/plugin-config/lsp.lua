-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Mappings.
  local opts = { noremap=true, silent=true }

  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua require("telescope.builtin").lsp_definitions()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua require("telescope.builtin").lsp_references()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua require("telescope.builtin").lsp_implementations()<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua require("telescope.builtin").lsp_type_definitions()<CR>', opts)

  buf_set_keymap('n', '<space>gw', '<cmd>lua require("telescope.builtin").lsp_document_symbols()<CR>', opts)
  buf_set_keymap('n', '<space>gW', '<cmd>lua require("telescope.builtin").lsp_dynamic_workspace_symbols()<CR>', opts)

  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)

  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('v', '<space>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)

  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  buf_set_keymap('v', '<space>f', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)

  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua require("telescope.builtin").lsp_document_diagnostics()<CR>', opts)

  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- npm install -g @angular/language-server
require'lspconfig'.angularls.setup{
    capabilities = capabilities,
    on_attach = on_attach
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
            formattingProvider = "brittany"
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
                vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
            end
        }
    }
}

-- npm install -g typescript-language-server
require'lspconfig'.tsserver.setup{
    capabilities = capabilities,
    on_attach = on_attach
}

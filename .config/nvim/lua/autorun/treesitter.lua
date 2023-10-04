require('nvim-treesitter.configs').setup({
  modules = {},
  ensure_installed = {},
  sync_install = false,
  auto_install = true,
  ignore_install = { 'all' },
  highlight = {
    enable = true,
    disable = function()
      return vim.fn.line2byte(vim.fn.line("$") + 1) > 100000
    end,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
    disable = function()
      return vim.fn.line2byte(vim.fn.line("$") + 1) > 100000
    end,
  },
  context_commentstring = {
    enable = true,
  },
})

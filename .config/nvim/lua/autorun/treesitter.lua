require('nvim-treesitter.configs').setup({
  ensure_installed = 'all',
  sync_install = false,
  auto_install = true,
  ignore_install = { 'phpdoc' },
  highlight = {
    enable = true,
    disable = function()
        return vim.fn.line2byte(vim.fn.line("$") + 1) > 1000000
    end,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true
  },
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
  },
  context_commentstring = {
    enable = true,
  },
})

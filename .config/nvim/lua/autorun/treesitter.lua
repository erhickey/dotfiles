require('nvim-treesitter').install {
  'c',
  'bash',
  'angular',
  'haskell',
  'javascript',
  'lua',
  'markdown',
  'nix',
  'python',
  'rust',
  'sql',
  'typescript',
  'vim',
  'vimdoc',
}

require('treesitter-context').setup()

local filetypes = {
  'c',
  'bash',
  'haskell',
  'htmlangular',
  'javascript',
  'lua',
  'markdown',
  'nix',
  'python',
  'rust',
  'sql',
  'typescript',
  'vim',
}

for _, filetype in pairs(filetypes) do
  vim.api.nvim_create_autocmd('FileType', {
    pattern = { filetype },
    callback = function()
      -- enable treesitter syntax highlighting
      vim.treesitter.start()
      -- enable treesitter folding
      vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.wo[0][0].foldmethod = 'expr'
    end,
  })
end

-- all folds open on file open
vim.opt.foldlevelstart = 99

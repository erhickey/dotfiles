local Plug = vim.fn['plug#']

vim.call('plug#begin')

    Plug 'neovim/nvim-lspconfig'

    Plug 'editorconfig/editorconfig-vim'

    Plug 'junegunn/fzf.vim'

    Plug 'tpope/vim-fugitive'

    -- nvim-cmp and supporting sources
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/nvim-cmp'

    -- vsnip and supporting sources
    Plug 'hrsh7th/vim-vsnip'
    Plug 'rafamadriz/friendly-snippets'

    -- colored icons, required by other plugins
    Plug 'kyazdani42/nvim-web-devicons'

    -- tabs at top for each buffer, requires nerdfont
    Plug 'akinsho/bufferline.nvim'

    -- identify lsp kinds with text/icon, requires nerdfont
    Plug 'onsails/lspkind-nvim'

    -- enhance lsp ui
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'

    -- display function signature popup
    Plug 'ray-x/lsp_signature.nvim'

    -- required to add parens after function completion
    Plug 'windwp/nvim-autopairs'

    -- indicate modified lines in VCS managed files
    Plug 'mhinz/vim-signify'

vim.call('plug#end')

-- load all lua files in plugin-config
-- files are loaded in order alphabetically
for filename in io.popen('ls -pqAL "$HOME/.config/nvim/lua/plugin-config"'):lines() do
  filename = filename:match'^(.*)%.lua$'
  if filename then
    require('plugin-config/'..filename)
  end
end

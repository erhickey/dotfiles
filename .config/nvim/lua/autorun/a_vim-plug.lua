local Plug = vim.fn['plug#']

vim.call('plug#begin')

    -- ----------------------
    -- LSP
    -- ----------------------
    Plug 'neovim/nvim-lspconfig'
    -- identify lsp kinds with text/icon, requires nerdfont
    Plug 'onsails/lspkind-nvim'
    -- display function signature popup
    Plug 'ray-x/lsp_signature.nvim'

    -- ----------------------
    -- treesitter
    -- ----------------------
    Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
    Plug 'nvim-treesitter/nvim-treesitter-context'
    -- make comment string context aware
    Plug 'JoosepAlviste/nvim-ts-context-commentstring'
    -- rainbow colored pairs
    Plug 'p00f/nvim-ts-rainbow'

    -- ----------------------
    -- git
    -- ----------------------
    Plug 'tpope/vim-fugitive'
    Plug 'lewis6991/gitsigns.nvim'

    -- ----------------------
    -- markup language
    -- ----------------------
    Plug 'mattn/emmet-vim'
    Plug 'alvan/vim-closetag'
    -- auto-update matching html/xml tag
    Plug 'AndrewRadev/tagalong.vim'

    -- ----------------------
    -- nvim-cmp
    -- ----------------------
    Plug 'hrsh7th/cmp-nvim-lsp'
    -- supporting sources
    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/nvim-cmp'
    -- required to add parens after nvim-cmp function completion
    Plug 'windwp/nvim-autopairs'
    -- snippet engine is required by nvim-cmp
    Plug 'hrsh7th/vim-vsnip'

    -- ----------------------
    -- SQL
    -- ----------------------
    Plug 'ivalkeen/vim-simpledb'

    -- ----------------------
    -- miscellaneous
    -- ----------------------
    Plug 'editorconfig/editorconfig-vim'
    Plug 'tpope/vim-commentary'
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'erhickey/buffer-command-vim'
    Plug 'erhickey/diagline-nvim'
    -- better quickfix window
    Plug 'kevinhwang91/nvim-bqf'
    -- easily jump to arbitraty point in view
    Plug 'easymotion/vim-easymotion'
    -- colored icons, required by other plugins
    Plug 'kyazdani42/nvim-web-devicons'

vim.call('plug#end')

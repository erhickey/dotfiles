local Plug = vim.fn['plug#']

vim.call('plug#begin')

    -- ----------------------
    -- LSP
    -- ----------------------
    Plug 'neovim/nvim-lspconfig'
    Plug 'williamboman/mason.nvim'
    Plug 'erhickey/sig-window-nvim'

    -- ----------------------
    -- treesitter
    -- ----------------------
    Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
    Plug 'nvim-treesitter/nvim-treesitter-context'      -- sticky context
    Plug 'JoosepAlviste/nvim-ts-context-commentstring'  -- context aware comment strings

    -- ----------------------
    -- nvim-cmp
    -- ----------------------
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/vim-vsnip'      -- a snippet engine is required by nvim-cmp
    Plug 'windwp/nvim-autopairs'  -- add parens after function completion

    -- ----------------------
    -- git
    -- ----------------------
    Plug 'tpope/vim-fugitive'
    Plug 'lewis6991/gitsigns.nvim'

    -- ----------------------
    -- markup language
    -- ----------------------
    Plug 'mattn/emmet-vim'
    Plug 'alvan/vim-closetag'       -- auto-close tags
    Plug 'AndrewRadev/tagalong.vim' -- auto-update matching tag

    -- ----------------------
    -- SQL
    -- ----------------------
    Plug 'tpope/vim-dadbod'
    Plug('napisani/nvim-dadbod-bg', { ['do'] = './install.sh' })
    Plug 'erhickey/bigquery-vim'

    -- ----------------------
    -- miscellaneous
    -- ----------------------
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'folke/which-key.nvim'
    Plug 'erhickey/buffer-command-vim'
    Plug 'erhickey/diagline-nvim'

vim.call('plug#end')

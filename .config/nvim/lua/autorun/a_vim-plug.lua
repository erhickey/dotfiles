local Plug = vim.fn['plug#']

vim.call('plug#begin')

    -- ----------------------
    -- LSP
    -- ----------------------
    Plug 'neovim/nvim-lspconfig'
    Plug 'ray-x/lsp_signature.nvim' -- function signature popup

    -- ----------------------
    -- treesitter
    -- ----------------------
    Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
    Plug 'nvim-treesitter/nvim-treesitter-context' -- sticky context
    Plug 'JoosepAlviste/nvim-ts-context-commentstring' -- make comment string context aware
    Plug 'p00f/nvim-ts-rainbow' -- rainbow colored pairs

    -- ----------------------
    -- nvim-cmp
    -- ----------------------
    Plug 'hrsh7th/nvim-cmp'
    -- supporting sources
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/vim-vsnip' -- snippet engine is required by nvim-cmp
    Plug 'windwp/nvim-autopairs' -- required to add parens after nvim-cmp function completion

    -- ----------------------
    -- git
    -- ----------------------
    Plug 'tpope/vim-fugitive'
    Plug 'lewis6991/gitsigns.nvim'

    -- ----------------------
    -- markup language
    -- ----------------------
    Plug 'mattn/emmet-vim'
    Plug 'alvan/vim-closetag' -- auto close html tags
    Plug 'AndrewRadev/tagalong.vim' -- auto-update matching html/xml tag

    -- ----------------------
    -- SQL
    -- ----------------------
    Plug 'ivalkeen/vim-simpledb' -- simple database client

    -- ----------------------
    -- miscellaneous
    -- ----------------------
    Plug 'editorconfig/editorconfig-vim'
    Plug 'tpope/vim-commentary'
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'kevinhwang91/nvim-bqf' -- better quickfix window
    Plug 'erhickey/buffer-command-vim'
    Plug 'erhickey/diagline-nvim'

vim.call('plug#end')

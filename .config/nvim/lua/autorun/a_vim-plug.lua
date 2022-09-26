local Plug = vim.fn['plug#']

vim.call('plug#begin')

    -- ----------------------
    -- LSP
    -- ----------------------
    Plug 'neovim/nvim-lspconfig'
    Plug 'onsails/lspkind-nvim' -- identify lsp kinds with text/icon, requires nerdfont
    Plug 'ray-x/lsp_signature.nvim' -- display function signature popup

    -- ----------------------
    -- treesitter
    -- ----------------------
    Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
    Plug 'nvim-treesitter/nvim-treesitter-context' -- sticky context
    Plug 'JoosepAlviste/nvim-ts-context-commentstring' -- make comment string context aware
    Plug 'p00f/nvim-ts-rainbow' -- rainbow colored pairs

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
    -- nvim-cmp
    -- ----------------------
    Plug 'hrsh7th/cmp-nvim-lsp'
    -- supporting sources
    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/vim-vsnip' -- snippet engine is required by nvim-cmp
    Plug 'windwp/nvim-autopairs' -- required to add parens after nvim-cmp function completion

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
    Plug 'kevinhwang91/nvim-bqf' -- better quickfix window
    Plug 'kyazdani42/nvim-web-devicons' -- colored icons, required by other plugins

vim.call('plug#end')

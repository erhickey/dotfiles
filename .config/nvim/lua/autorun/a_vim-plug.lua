local Plug = vim.fn['plug#']

vim.call('plug#begin')

    Plug 'erhickey/diagline-nvim'
    Plug 'erhickey/buffer-command-vim'

    Plug 'neovim/nvim-lspconfig'

    Plug 'editorconfig/editorconfig-vim'

    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'

    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-commentary'

    Plug 'mattn/emmet-vim'

    -- nvim-cmp and supporting sources
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/nvim-cmp'

    -- vsnip, a snippet engine is required by nvim-cmp
    Plug 'hrsh7th/vim-vsnip'

    -- required to add parens after nvim-cmp function completion
    Plug 'windwp/nvim-autopairs'

    -- colored icons, required by other plugins
    Plug 'kyazdani42/nvim-web-devicons'

    -- identify lsp kinds with text/icon, requires nerdfont
    Plug 'onsails/lspkind-nvim'

    -- display function signature popup
    Plug 'ray-x/lsp_signature.nvim'

    -- indicate modified lines in VCS managed files
    Plug 'mhinz/vim-signify'

    -- better quickfix window
    Plug 'kevinhwang91/nvim-bqf'

    -- create closing html/xml tag when completing opening tag
    Plug 'alvan/vim-closetag'
    -- auto-update matching html/xml tag
    Plug 'AndrewRadev/tagalong.vim'

    -- easily jump to arbitraty point in view
    Plug 'easymotion/vim-easymotion'

    -- simple database client plugin
    Plug 'ivalkeen/vim-simpledb'

vim.call('plug#end')

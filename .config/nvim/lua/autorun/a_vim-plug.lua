local Plug = vim.fn['plug#']

vim.call('plug#begin')

    -- ----------------------
    -- LSP
    -- ----------------------
    Plug 'neovim/nvim-lspconfig'
    Plug 'erhickey/sig-window-nvim'

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
    Plug 'hrsh7th/cmp-cmdline'
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
    Plug 'tpope/vim-dadbod'

    -- ----------------------
    -- miscellaneous
    -- ----------------------
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'kevinhwang91/nvim-bqf' -- better quickfix window
    Plug 'roy2220/easyjump.tmux'
    Plug 'erhickey/buffer-command-vim'
    Plug 'erhickey/diagline-nvim'

    -- Firenvim - nvim in the browser, requires browser addon
    -- Firefox: https://addons.mozilla.org/en-US/firefox/addon/firenvim/
    -- Chrome: https://chrome.google.com/webstore/detail/firenvim/egpjdkipkomnmjhjmdamaniclmdlobbo
    Plug('glacambre/firenvim', { ['do'] = vim.fn['firenvim#install(0)'] })

vim.call('plug#end')

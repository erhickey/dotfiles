call plug#begin()

    Plug 'neovim/nvim-lspconfig'

    Plug 'editorconfig/editorconfig-vim'
    Plug 'junegunn/fzf.vim'
    Plug 'tpope/vim-fugitive'

    " nvim-cmp and supporting sources
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/nvim-cmp'

    " colored icons
    Plug 'kyazdani42/nvim-web-devicons'

    " tabs at top for each buffer, requires nerdfont
    Plug 'akinsho/bufferline.nvim'

    " identify lsp kinds with text/icon, requires nerdfont
    Plug 'onsails/lspkind-nvim'

    " enhance lsp ui
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'

call plug#end()

" ensure that editorconfig plays well with fugitive
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" fzf.vim config
let g:fzf_preview_window = ['down:70%', 'ctrl-/']
nnoremap <a-o> :Files!<CR>
nnoremap <a-f> :Rg!<Cr>

lua require('plugin-config/lsp')
lua require('plugin-config/nvim-cmp')
lua require('plugin-config/devicons')
lua require('plugin-config/bufferline')
lua require('plugin-config/lspkind')
lua require('plugin-config/telescope')

call plug#begin()

Plug 'editorconfig/editorconfig-vim'

Plug 'neovim/nvim-lspconfig'

Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-fugitive'

call plug#end()


" ensure that editorconfig plays well with fugitive
let g:EditorConfig_exclude_patterns = ['fugitive://.*']


" fzf.vim config
let g:fzf_preview_window = ['down:70%', 'ctrl-/']

" fzf.vim key mappings
nnoremap <a-o> :Files!<CR>
nnoremap <a-f> :Rg!<Cr>

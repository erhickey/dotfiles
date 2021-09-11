set runtimepath^=~/.vim
let &packpath = &runtimepath
source ~/.vimrc

runtime ./plugins.vim
lua require('lsp')

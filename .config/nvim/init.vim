set runtimepath^=~/.vim
let &packpath = &runtimepath
source ~/.vimrc

set termguicolors
colorscheme solarized8_flat

runtime ./plugins.vim

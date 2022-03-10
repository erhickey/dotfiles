set runtimepath^=~/.vim
let &packpath = &runtimepath
source ~/.vimrc

lua require('plugins')

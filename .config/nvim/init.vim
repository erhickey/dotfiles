set runtimepath^=~/.vim
let &packpath = &runtimepath
source ~/.vimrc

lua require('plugins')

" support configuration that isn't supported in lua yet
runtime plugins.vim

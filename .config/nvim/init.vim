set runtimepath^=~/.vim
let &packpath = &runtimepath
source ~/.vimrc

lua require('plugins')

if &diff
  syntax off
endif

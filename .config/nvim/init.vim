set runtimepath^=~/.vim
let &packpath = &runtimepath
source ~/.vimrc

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  execute 'source '.data_dir.'/autoload/plug.vim'
endif

lua require('vim-plug')

if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  PlugInstall --sync
endif

lua require('autorun')

set background=dark
color elflord

if &t_Co > 8
    color solarized
endif

set encoding=utf-8

syntax enable " syntax highlighting
set showmatch " highlight syntax matching [{()}]

set tabstop=4 " number of spaces to visually replace tab with
set expandtab " insert spaces instead of tab
set softtabstop=4 " number of spaces inserted when tab is pressed
set shiftwidth=4 " number of spaces used by auto-indent and following key strokes: >> << ==
set autoindent

set ignorecase " case insensitive search
set smartcase " case sensitive search when caps are used
set incsearch " search as characters are entered
set hlsearch " highlight search matches
nnoremap <silent> <C-L> :nohl<CR>

set nowrap
set scrolloff=5 " minimum number of lines to keep above/below cursor
set sidescroll=1 " minimum number of columns to scroll horizontally (don't auto-center)
set sidescrolloff=20 " minimum number of columns to keep to left/right of cursor
set visualbell " visual bell instead of beep

set wildmenu " visual autocomplete for command menu
set cmdheight=2 " increase height of command line
set laststatus=2 " always show status bar

set shell=bash
set hidden " hide buffer instead of closing it when opening a new file
set lazyredraw " redraw only when needed, avoid redrawing during macros

set list
set listchars=tab:>\ ,trail:␣,extends:>,precedes:<,nbsp:@

set ruler " line,column numbers
set number relativenumber " hybrid line number gutter

set cursorcolumn " highlight current column
set cursorline " highlight current row
hi clear cursorline " clear cursorline, leave enabled for cursorlinenr
" remove current line number underline
hi cursorlinenr cterm=bold

set formatoptions+=j " delete comment character when joining lines

let mapleader="\<Space>"

filetype plugin indent on

if &diff
    syntax off
endif

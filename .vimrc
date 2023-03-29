set background=dark
color elflord

if &t_Co > 8
  color solarized

  if has('termguicolors')
    set termguicolors
    color solarized8_flat
    " tmux true color fix required by some terminals
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  endif
endif

set encoding=utf-8
set mouse=a

syntax enable " syntax highlighting
set showmatch " highlight syntax matching [{()}]

set tabstop=2 " number of spaces to visually replace tab with
set expandtab " insert spaces instead of tab
set softtabstop=2 " number of spaces inserted when tab is pressed
set shiftwidth=2 " number of spaces used by auto-indent and following key strokes: >> << ==
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
set laststatus=2 " always show status bar

set shell=bash
set hidden " hide buffer instead of closing it when opening a new file
set lazyredraw " redraw only when needed, avoid redrawing during macros

set list
set listchars=tab:>\ ,trail:␣,extends:>,precedes:<,nbsp:@

set ruler " line,column numbers
set number relativenumber " hybrid line number gutter
nnoremap <silent> <C-K> :set nonumber! norelativenumber!<CR>

set cursorcolumn " highlight current column
set cursorline " highlight current row
" hi clear cursorline " clear cursorline highlight, leave enabled for cursorlinenr
" remove current line number underline
hi cursorlinenr cterm=bold

set colorcolumn=121

set formatoptions+=j " delete comment character when joining lines

" highlight non-ascii characters
highlight nonascii guifg=#ffffff guibg=#ff0000 ctermfg=white ctermbg=red
match nonascii "[^\d0-\d127]"

let mapleader="\<Space>"
set timeout timeoutlen=500 ttimeoutlen=25

" move between paragrphs without storing the motion in the jumplist
nnoremap <silent> } :<C-u>execute "keepjumps norm! " . v:count1 . "}"<CR>
nnoremap <silent> { :<C-u>execute "keepjumps norm! " . v:count1 . "{"<CR>

" copy to system clipboard
nnoremap Y "+y
vnoremap Y "+y

filetype plugin indent on

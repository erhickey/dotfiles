#!/usr/bin/env bash

# no preview window, but bind half-page-[up/down] for fzf.vim
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --multi --bind ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down"
export FZF_DEFAULT_COMMAND='fd -L .'

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d .'

#!/usr/bin/env bash

__fzf-edit__() {
  files=$(fzf) && nvim $files
}

bind -m emacs-standard -x '"\C-e": __fzf-edit__'
bind -m vi-command -x '"\C-e": __fzf-edit__'
bind -m vi-insert -x '"\C-e": __fzf-edit__'

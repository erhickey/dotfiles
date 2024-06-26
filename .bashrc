#!/usr/bin/env bash

[[ $- != *i* ]] && return # abort if shell is non-interactive

[ -e /etc/bashrc ] && source /etc/bashrc

set -o vi
shopt -sq checkwinsize # auto update LINES and COLUMNS
shopt -sq histappend

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias sh='bash'
alias ssh='ssh -o ServerAliveInterval=240 -o SendEnv=COLORTERM'
command -v vim &> /dev/null && alias vi='vim'
command -v nvim &> /dev/null && alias vi='nvim'

shell="$(which bash)"
export SHELL="$shell"
export VISUAL=vim
export EDITOR="$VISUAL"
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
export HISTSIZE=100000
export HISTFILESIZE=100000
export GREP_COLORS='mt=48;5;3;38;5;7'
export BASH_SILENCE_DEPRECATION_WARNING=1

for file in ~/.bash_autoload/* ; do
  [ -e "$file" ] && source "$file"
done

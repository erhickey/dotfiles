#!/usr/bin/env bash

# don't set PATH in .bashrc to avoid duplicate paths in non-login shells
export PATH="$PATH:$HOME/bin"
[ -d "$HOME"/.cabal ] && export PATH="$PATH:$HOME/.cabal/bin"

[ -f "$HOME"/.bashrc ] && source "$HOME"/.bashrc

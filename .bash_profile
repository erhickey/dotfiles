#!/usr/bin/env bash

# set path here (instead of in .bashrc) to avoid duplicate paths in non-login shells

PATH="$PATH:$HOME/bin"
PATH="$PATH:$HOME/.cabal/bin"
PATH="/nix/var/nix/profiles/default/bin:$PATH"
PATH="$HOME/.nix-profile/bin:$PATH"
export PATH

export MANPATH="$HOME/.nix-profile/share/man:/nix/var/nix/profiles/default/share/man:$MANPATH"

[ -f "$HOME"/.bashrc ] && source "$HOME"/.bashrc

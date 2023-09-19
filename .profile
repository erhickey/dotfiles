#!/usr/bin/env sh

PATH="$PATH:$HOME/.cabal/bin"
PATH="$PATH:$HOME/.npm-packages/bin"
PATH="/nix/var/nix/profiles/default/bin:$PATH"
PATH="$HOME/.nix-profile/bin:$PATH"
export PATH

export MANPATH="$HOME/.nix-profile/share/man:/nix/var/nix/profiles/default/share/man:$MANPATH"

[ -f "$HOME"/.bashrc ] && . "$HOME"/.bashrc

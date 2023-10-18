#!/usr/bin/env sh

PATH="$PATH:$HOME/.cabal/bin"
PATH="$PATH:$HOME/.npm-packages/bin"
PATH="/nix/var/nix/profiles/default/bin:$PATH"
PATH="$HOME/.nix-profile/bin:$PATH"
export PATH

export MANPATH="$HOME/.nix-profile/share/man:/nix/var/nix/profiles/default/share/man:$MANPATH"

[ -e "$HOME"/.bashrc ] && . "$HOME"/.bashrc

if [ -z "$DISPLAY" ] && [ -e "$HOME"/.xinitrc ] && [ "$(fgconsole 2> /dev/null || printf "0")" -eq 1 ] ; then
  startx
fi

#!/usr/bin/env bash

# in case nix was installed for single user
[ -e "$HOME"/.nix-profile/etc/profile.d/nix.sh ] && source "$HOME"/.nix-profile/etc/profile.d/nix.sh

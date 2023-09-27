#!/usr/bin/env bash

# in case nix was installed for single user
[ -e "$HOME"/.nix-profile/etc/profile.d/nix.sh ] && source "$HOME"/.nix-profile/etc/profile.d/nix.sh

# may be necessary to point to system's locale archive
[ -e /usr/lib/locale/locale-archive ] && export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive

# might be necessary for home manager?
# [ -e "$HOME"/.nix-profile/etc/profile.d/hm-session-vars.sh ] && source "$HOME"/.nix-profile/etc/profile.d/hm-session-vars.sh

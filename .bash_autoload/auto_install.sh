#!/usr/bin/env bash

function get_file {
  source_file="$1"
  target_file="$2"
  pretty_label="$3"

  printf 'Retrieving %s...' "$pretty_label"
  (curl -fLso "$target_file" --create-dirs "$source_file" && \
    printf 'done\n') || printf 'FAILED !!!\n'
}

[ -e ~/.bash_autoload/fzf-key-bindings.sh ] || get_file https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.bash ~/.bash_autoload/fzf-key-bindings.sh "fzf key bindings"
[ -e ~/.bash_autoload/fzf-completion.sh ] || get_file https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.bash ~/.bash_autoload/fzf-completion.sh "fzf completion"
[ -e ~/.bash_autoload/git-completion.bash ] || get_file https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash ~/.bash_autoload/git-completion.bash "git completion"

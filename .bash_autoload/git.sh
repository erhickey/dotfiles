#!/usr/bin/env bash

alias gitlog='git log --graph --pretty=format:"%Cred%H%Creset -%C(yellow)%d%Creset %s %Cgreen(%cD) (%cr) %C(bold blue)<%an>%Creset"'

[ -e ~/.bash_autoload/git-completion.bash ] || curl -fLso ~/.bash_autoload/git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash && source ~/.bash_autoload/git-completion.bash

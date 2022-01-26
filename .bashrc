[ -f /etc/bashrc ] && source /etc/bashrc

set -o vi
shopt -sq checkwinsize # auto update LINES and COLUMNS
shopt -sq histappend

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias sh='bash'
alias ssh='ssh -o ServerAliveInterval=240'
alias gitlog='git log --graph --pretty=format:"%Cred%H%Creset -%C(yellow)%d%Creset %s %Cgreen(%cD) (%cr) %C(bold blue)<%an>%Creset"'
command -v vim &> /dev/null && alias vi='vim'

export VISUAL=vim
export EDITOR="$VISUAL"
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
export HISTSIZE=100000
export HISTFILESIZE=100000
export GREP_COLOR='48;5;3;38;5;7'

for file in ~/.bash_autoload/* ; do
  [ -e "$file" ] && source "$file"
done

# on a mac one of the scripts in autoload should have added homebrew/bin to the path environment variable
# use/alias gnu coreutils if they are now available
[ -e "$HOME"/.dircolors ] && eval $(dircolors "$HOME"/.dircolors 2> /dev/null || gdircolors "$HOME"/.dircolors)
command -v gdate &> /dev/null && alias date='gdate'
command -v gls &> /dev/null && alias ls='gls --color=auto'

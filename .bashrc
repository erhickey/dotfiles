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

export COLOR_RESET="\\e[0m"
export FG_RESET="\\e[38;5;12m"
export BG_RESET="\\e[48;5;8m"

export FG_RED="\\e[38;5;1m"
export FG_GREEN="\\e[38;5;2m"
export FG_YELLOW="\\e[38;5;3m"
export FG_BLUE="\\e[38;5;4m"
export FG_CYAN="\\e[38;5;6m"
export FG_WHITE="\\e[38;5;7m"
export FG_ORANGE="\\e[38;5;9m"
export FG_BLACK="\\e[38;5;16m"
export FG_REVERSE="\\e[38;5;8m"

export BG_RED="\\e[48;5;1m"
export BG_GREEN="\\e[48;5;2m"
export BG_YELLOW="\\e[48;5;3m"
export BG_BLUE="\\e[48;5;4m"
export BG_CYAN="\\e[48;5;6m"
export BG_WHITE="\\e[48;5;7m"
export BG_ORANGE="\\e[48;5;9m"
export BG_BLACK="\\e[48;5;16m"

for file in ~/.bash_autoload/* ; do
  [ -e "$file" ] && source "$file"
done

# wait to use gnu coreutils until after they are accessible via path
[ -e "$HOME"/.dircolors ] && eval $(dircolors "$HOME"/.dircolors 2> /dev/null || gdircolors "$HOME"/.dircolors)
command -v gdate &> /dev/null && alias date='gdate'

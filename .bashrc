if [ -f /etc/bashrc ] ; then
  source /etc/bashrc
fi

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
[ -e "$HOME"/.dircolors ] && eval $(dircolors "$HOME"/.dircolors)

export COLOR_RESET="\\e[0m"
export FG_DEFAULT="\\e[12m"
export BG_DEFAULT="\\e[8m"

export FG_BLACK="\\e[38;5;16m"
export FG_RED="\\e[38;5;1m"
export FG_GREEN="\\e[38;5;2m"
export FG_YELLOW="\\e[38;5;3m"
export FG_BLUE="\\e[38;5;4m"
export FG_CYAN="\\e[38;5;6m"
export FG_ORANGE="\\e[38;5;9m"
export FG_WHITE="\$FG_DEFAULT"

export BG_BLACK="\\e[48;5;16m"
export BG_RED="\\e[48;5;1m"
export BG_GREEN="\\e[48;5;2m"
export BG_YELLOW="\\e[48;5;3m"
export BG_BLUE="\\e[48;5;4m"
export BG_CYAN="\\e[48;5;6m"
export BG_ORANGE="\\e[48;5;9m"
export BG_WHITE="\\e[48;5;12m"

hostname="$(hostname)"
host_color="$FG_CYAN"

set_git_branch() {
  if cbranch="$(git symbolic-ref --short HEAD 2> /dev/null)"; then
      PS1_GIT_BRANCH="($cbranch)"
  else
      unset PS1_GIT_BRANCH
  fi
}

set_error_prompt() {
  if [ $? -eq 0 ] ; then
      unset PS1_ERROR_PROMPT
  else
      PS1_ERROR_PROMPT="-> ($?)"
  fi
}

prompt_command() {
  set_error_prompt

  history -a
  history -c
  history -r

  set_git_branch
}

PS1="\\[$FG_ORANGE\\][\\[$FG_CYAN\\]\\u\\[$FG_CYAN\\]@\\[$host_color\\]$hostname\\[$FG_ORANGE\\]] \\[$FG_BLUE\\]\\w \\[$FG_GREEN\\]$(printf '$PS1_GIT_BRANCH')\\[$FG_RED\\] $(printf '$PS1_ERROR_PROMPT')\\[$COLOR_RESET\\]\\n\\[$FG_ORANGE\\][\\[$FG_YELLOW\\]\\t \\d\\[$FG_ORANGE\\]] \\[$FG_BLUE\\]$\\[$COLOR_RESET\\] "

PROMPT_COMMAND=prompt_command

for file in ~/.bash_autoload/* ; do
  [ -e "$file" ] && source "$file"
done

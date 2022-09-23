#!/usr/bin/env bash

pre_command_exec() {
  printf '\e[0m'

  [ -n "$COMMAND_EXECUTING" ] && return
  COMMAND_EXECUTING=1

  COMMAND_START="$(date +%s%3N)"
}

post_command_exec() {
  [ -z "$COMMAND_EXECUTING" ] && return
  unset COMMAND_EXECUTING

  COMMAND_END="$(date +%s%3N)"
  COMMAND_DURATION_DISPLAY="0.000"
  # skip if date did not give desired output, e.g., when macos date util is used
  if [[ "$COMMAND_END" != *N ]] && [[ "$COMMAND_START" != *N ]] ; then
    COMMAND_DURATION="$((COMMAND_END - COMMAND_START))"
    CD_SECS="$((COMMAND_DURATION / 1000))"
    CD_MILLIS="$((COMMAND_DURATION - CD_SECS * 1000))"
    COMMAND_DURATION_DISPLAY="$CD_SECS.$(printf '%03d' "$CD_MILLIS")"
  fi
  COMMAND_DURATION_DISPLAY="${COMMAND_DURATION_DISPLAY}s❩"
}

trap pre_command_exec DEBUG

set_error_prompt() {
  local return_code="$?"
  if [ "$return_code" -eq 0 ] ; then
    unset PS1_ERROR_PROMPT
  else
    export PS1_ERROR_PROMPT=" ${return_code}"
  fi
}

set_git_branch() {
  if cbranch="$(git symbolic-ref --short HEAD 2> /dev/null)"; then
    export PS1_GIT_BRANCH="  $cbranch"
  else
    unset PS1_GIT_BRANCH
  fi
}

prompt_command() {
  set_error_prompt
  post_command_exec

  history -a
  history -c
  history -r

  set_git_branch
}

COLOR_RESET="\\[\\e[0m\\]"
BOLD_TEXT="\\[\\e[1m\\]"
FG_RESET="\\e[38;5;12m\\]"
BG_RESET="\\e[48;5;8m\\]"

FG_RED="\\[\\e[38;5;1m\\]"
FG_GREEN="\\[\\e[38;5;2m\\]"
FG_YELLOW="\\[\\e[38;5;3m\\]"
FG_BLUE="\\[\\e[38;5;4m\\]"
FG_CYAN="\\[\\e[38;5;6m\\]"
FG_WHITE="\\[\\e[38;5;7m\\]"
FG_ORANGE="\\[\\e[38;5;9m\\]"
FG_BLACK="\\[\\e[38;5;16m\\]"
FG_REVERSE="\\[\\e[38;5;8m\\]"

BG_RED="\\[\\e[48;5;1m\\]"
BG_GREEN="\\[\\e[48;5;2m\\]"
BG_YELLOW="\\[\\e[48;5;3m\\]"
BG_BLUE="\\[\\e[48;5;4m\\]"
BG_CYAN="\\[\\e[48;5;6m\\]"
BG_WHITE="\\[\\e[48;5;7m\\]"
BG_ORANGE="\\[\\e[48;5;9m\\]"
BG_BLACK="\\[\\e[48;5;16m\\]"

PS1="$BOLD_TEXT$FG_BLUE\\w$FG_YELLOW\$PS1_GIT_BRANCH$FG_RED\$PS1_ERROR_PROMPT\\n$FG_ORANGE\$COMMAND_DURATION_DISPLAY$FG_CYAN "

PROMPT_COMMAND=prompt_command

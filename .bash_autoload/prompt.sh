#!/usr/bin/env bash

pre_command_exec() {
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
  COMMAND_DURATION_DISPLAY="${COMMAND_DURATION_DISPLAY}s"
}

trap pre_command_exec DEBUG

set_error_prompt() {
  if [ $? -eq 0 ] ; then
    unset PS1_ERROR_PROMPT
  else
    PS1_ERROR_PROMPT=" $?"
  fi
}

set_git_branch() {
  if cbranch="$(git symbolic-ref --short HEAD 2> /dev/null)"; then
    PS1_GIT_BRANCH="  $cbranch"
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

PS1="\\[$FG_BLUE\]\\w\\[$FG_YELLOW\\]$(printf "%s" '$PS1_GIT_BRANCH')\\[$FG_RED\\]$(printf "%s" '$PS1_ERROR_PROMPT')\\[$COLOR_RESET\\]\\n\\[$FG_ORANGE\\]$(printf "%s" '$COMMAND_DURATION_DISPLAY')\\[$COLOR_RESET\\]"

PROMPT_COMMAND=prompt_command

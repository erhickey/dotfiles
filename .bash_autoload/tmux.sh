#!/usr/bin/env bash

function cht_tmux() {
  read -rp "? " query
  curl -s "cht.sh/$(replace_spaces "$query")" | bat --pager "less -R"
}

function hoogle_tmux() {
  read -rp "λ " query
  hoogle search --color --count=100 "$query" | bat --pager "less -R"
}

function replace_spaces() {
  printf '%s' "$1" | tr ' ' '+'
}

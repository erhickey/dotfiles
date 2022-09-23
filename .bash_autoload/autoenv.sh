#!/usr/bin/env bash

function autoenv() {
  if [[ -n "$VIRTUAL_ENV" ]] ; then
    [[ "$(pwd -P)"/ != "$(dirname "$VIRTUAL_ENV")"/* ]] && deactivate
  fi

  if [[ -z "$VIRTUAL_ENV" ]] ; then
    if [[ -d .venv ]] ; then
      source .venv/bin/activate
    fi

    if [[ -d venv ]] ; then
      source venv/bin/activate
    fi
  fi
}

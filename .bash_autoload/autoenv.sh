#!/usr/bin/env bash

function python_venv() {
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

function nix_develop() {
  if [ -f ./flake.nix ] ; then
    :
  fi
}

function autoenv() {
  python_venv
  nix_develop
}

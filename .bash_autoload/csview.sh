#!/usr/bin/env bash

function csview() {
  sed -e 's/,,/, ,/g' "$1" | column -s, -t | less -#5 -N -S
}

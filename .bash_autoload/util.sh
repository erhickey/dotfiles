#!/usr/bin/env bash

function clipb() {
  case "$(uname -a)" in

    *Microsoft*)
      clip.exe
      ;;

    *Darwin*)
      pbcopy
      ;;

    *)
      xclip -selection clipboard
      ;;

  esac
}

function colors() {
  for fgbg in 38 48 ; do
    for color in {0..255} ; do
      printf '\e[%s;5;%sm  %3s  \e[0m' "$fgbg" "$color" "$color"

      [ $(( (color + 1) % 6)) == 4 ] && printf '\n'
    done

    printf '\n'
  done
}

function lsg() {
  dir=.
  [ $# -ge 0 ] && dir="$1"

  case "$(uname -a)" in

    *Microsoft*)
      explorer.exe "$dir"
      ;;

    *Darwin*)
      open "$dir"
      ;;

    *)
      xdg-open "$dir"
      ;;

  esac
}

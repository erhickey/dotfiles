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

function get_file {
  source_file="$1"
  target_file="$2"
  pretty_label="$3"

  printf 'Retrieving %s...' "$pretty_label"
  (curl -fLso "$target_file" --create-dirs "$source_file" && \
    printf 'done\n') || printf 'FAILED !!!\n'
}

function install_misc() {
  get_file https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.256dark ~/.dircolors "solarized dir colors"
  get_file https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.bash ~/.bash_autoload/fzf-key-bindings.sh "fzf key bindings"
  get_file https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.bash ~/.bash_autoload/fzf-completion.sh "fzf completion"
  get_file https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash ~/.bash_autoload/git-completion.bash "git completion"
}

function install_fonts() {
  if uname -a | grep -q 'Darwin' ; then
    get_file https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/LiberationMono/LiterationMonoNerdFont-Regular.ttf ~/Downloads/Literation-Mono-Nerd-Font-Regular.ttf 'Literation Mono Nerd Font'
    get_file https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/LiberationMono/LiterationMonoNerdFont-Bold.ttf ~/Downloads/Literation-Mono-Nerd-Font-Bold.ttf 'Literation Mono Nerd Font Bold'
    get_file https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/LiberationMono/LiterationMonoNerdFont-Italic.ttf ~/Downloads/Literation-Mono-Nerd-Font-Italic.ttf 'Literation Mono Nerd Font Italic'
    get_file https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/LiberationMono/LiterationMonoNerdFont-BoldItalic.ttf ~/Downloads/Literation-Mono-Nerd-Font-Bold-Italic.ttf 'Literation Mono Nerd Font Bold Italic'
    open ~/Downloads/Literation-Mono-Nerd-Font-Regular.ttf
    open ~/Downloads/Literation-Mono-Nerd-Font-Bold.ttf
    open ~/Downloads/Literation-Mono-Nerd-Font-Italic.ttf
    open ~/Downloads/Literation-Mono-Nerd-Font-Bold-Italic.ttf
  else
    printf 'installing fonts\nsudo '
    GET_FILE="$(declare -f get_file)"
    sudo sh -c "$GET_FILE ; get_file https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/LiberationMono/LiterationMonoNerdFont-Regular.ttf /usr/share/fonts/TTF/Literation-Mono-Nerd-Font-Regular.ttf 'Literation Mono Nerd Font'"
    sudo sh -c "$GET_FILE ; get_file https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/LiberationMono/LiterationMonoNerdFont-Bold.ttf /usr/share/fonts/TTF/Literation-Mono-Nerd-Font-Bold.ttf 'Literation Mono Nerd Font Bold'"
    sudo sh -c "$GET_FILE ; get_file https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/LiberationMono/LiterationMonoNerdFont-Italic.ttf /usr/share/fonts/TTF/Literation-Mono-Nerd-Font-Italic.ttf 'Literation Mono Nerd Font Italic'"
    sudo sh -c "$GET_FILE ; get_file https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/LiberationMono/LiterationMonoNerdFont-BoldItalic.ttf /usr/share/fonts/TTF/Literation-Mono-Nerd-Font-Bold-Italic.ttf 'Literation Mono Nerd Font Bold Italic'"
    printf '\nRebuilding font cache...\n'
    fc-cache -f -v
  fi
}

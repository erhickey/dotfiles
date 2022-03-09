function cht_tmux() {
  read -p "? " query
  curl -s "cht.sh/$query" | bat --pager "less -R"
}

function hoogle_tmux() {
  read -p "λ " query
  hoogle search --color --count=100 "$query" | bat --pager "less -R"
}

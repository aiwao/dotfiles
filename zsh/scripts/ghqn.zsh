ghqn() {
  local query=""
  if [[ $# -gt 0 ]]; then
    query="--query=$@"
  fi

  local selected=$(ghq list --full-path | roots | fzf $query --height 40% --reverse)
  if [[ -e "$selected" ]] then
    cd "$selected"
  fi
}

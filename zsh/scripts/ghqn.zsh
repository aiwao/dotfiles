ghqn() {
  local selected=$(ghq list --full-path | roots | fzf --height 40% --reverse)
  if [[ -e "$selected" ]] then
    cd "$selected"
  fi
}

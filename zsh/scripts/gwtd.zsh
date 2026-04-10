gwtd() {
  if [[ $# -lt 1 ]]; then
    echo "Usage: gwtd <branch>"
    return 1
  fi

  local root="$(git_root)" || return 1
}

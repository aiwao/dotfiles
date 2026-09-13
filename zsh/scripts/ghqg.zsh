ghqg() {
  if [[ $# -eq 0 ]]; then
    echo "Usage: ghqg <repository> <ghq get arguments>"
    return 1
  fi
  local repository=$1
  local repo_path

  repo_path="$(ghq get "$repository" "${@:2}")" || return 1
  cd "$repo_path"
}

ghqg() {
  if [[ $# -eq 0 ]]; then
    echo "Usage: ghqg <repository> <ghq get arguments>"
    return 1
  fi
  local repository=$1
  local ghq_root="$(ghq root)" || return 1
  ghq get "$repository" "${@:2}" || return 1

  echo "$ghq_root/${base:h:t:r}"

  local repo_path="${repository#*://*}"
  repo_path="${repo_path%%[?#]*}"
  repo_path="${repo_path:r}"
  cd "$ghq_root/${repo_path}"
}

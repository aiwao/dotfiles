ghqc() {
  if [[ $# -le 1 ]]; then
    echo "Usage: ghqc <name> <gh repo create arguments>"
    return 1
  fi
  local HOST="github.com"
  local name=$1
  local username="$(git_remote_username $HOST)" || return 1
  local ghq_root="$(ghq root)" || return 1
  local repository="$HOST/$username/$name"

  ghq create "$name" || return 1
  gh repo create $@ || {
    ghq rm "$name"
    return 1
  }

  cd "$ghq_root/$repository"
  git remote add origin "https://$repository.git"
}

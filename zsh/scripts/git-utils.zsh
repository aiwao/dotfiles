git_root() {
  local root
  root="$(git rev-parse --show-toplevel 2>/dev/null)" || {
    echo "You are not in a git repo" >&2
    return 1
  }
  echo "$root"
}

git_remote_username() {
  result=$(gh auth status --json hosts --jq '.hosts["'"$1"'"][] | select(.active) | .login')

  if [ -z "$result" ]; then
    echo "You have not active account on $1" >&2
    return 1
  fi

  echo "$result"
}

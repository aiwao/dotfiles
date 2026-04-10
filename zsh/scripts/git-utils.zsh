git_root() {
  local root
  root="$(git rev-parse --show-toplevel 2>/dev/null)" || {
    echo "You are not in a git repo" >&2
    return 1
  }
  echo "$root"
}

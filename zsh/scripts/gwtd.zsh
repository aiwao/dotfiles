gwtd() {
  if [[ $# -lt 1 ]]; then
    echo "Usage: gwtd <branch>"
    return 1
  fi
  local target_branch=$1

  local wt_path="$(git worktree list | awk -v b=$target_branch "\$0 ~ b { print \$1 }")" || return 1
  echo $wt_path
  if [[ ! -e $wt_path ]] then
    echo "Failed to locale worktree dir"
    return 1
  fi
  
  git-wt -d $target_branch || return 1
  
  echo -n "Remove a workspace? (y/n): "
  read rm_work
  case $rm_work in
    [Yy]*) rm -rf $wt_path ;;
    [Nn]*) exit 0 ;;
    *)     echo "Please answer y or n" >&2; exit 1 ;;
  esac

  if git branch -r | grep -q "^ *origin/$target_branch\$"; then
    echo -n "Remove a remote branch? (y/n): "
    read rm_rem_br
    case $rm_rem_br in
      [Yy]*) git push origin --delete $target_branch ;;
      [Nn]*) exit 0 ;;
      *)     echo "Please answer y or n" >&2; exit 1 ;;
    esac
  fi
}

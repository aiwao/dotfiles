gignore() {
  local rm_current=0
  local COPY_TO="./.gitignore"
  if [[ -f "$COPY_TO" ]]; then
    echo "$COPY_TO is already exist"
    echo -n "Overwrite? (y/n): "
    read overwrite
    case $overwrite in
      [Yy]*) rm_current=1;;
      [Nn]*) exit 0 ;;
      *)     echo "Please answer y or n" >&2; exit 1 ;;
    esac
  fi

  local CONFIG_HOME="$(config_home)"
  local GITIGNORE="$CONFIG_HOME/git/ignore"
  if [[ ! -f "$GITIGNORE" ]]; then
    echo "$GITIGNORE is not found"
    return 1
  fi
  
  if [[ $rm_current -eq 1 ]]; then
    rm -f "$COPY_TO"
    echo "Removed $COPY_TO"
  fi
  cp "$GITIGNORE" "$COPY_TO" || return 1
  echo "$GITIGNORE Copied to $COPY_TO"
}

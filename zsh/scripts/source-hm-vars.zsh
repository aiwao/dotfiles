source-hm-vars() {
  unset __HM_SESS_VARS_SOURCED

  HM_SESSION_VARS="$HOME/.local/state/home-manager/gcroots/current-home/home-path/etc/profile.d/hm-session-vars.sh"
  if [ -f "$HM_SESSION_VARS" ]; then
    . "$HM_SESSION_VARS"
  fi
}

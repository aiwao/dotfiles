_: {
  programs.zsh = {
    enable = true;
    initContent = ''
      . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
    '';
  };
}

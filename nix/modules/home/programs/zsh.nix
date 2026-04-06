{
  homedir,
  ...
}
: {
  programs.zsh = {
    enable = true;
    initContent = ''
      . "${homedir}/.nix-profile/etc/profile.d/hm-session-vars.sh"
    '';
  };
}

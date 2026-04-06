{
  homedir,
  ...
}: {
  programs.bash = {
    enable = true;
    initExtra = ''
      . "${homedir}/.nix-profile/etc/profile.d/hm-session-vars.sh"
    '';
  };
} 

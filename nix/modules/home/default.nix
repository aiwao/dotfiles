{
  pkgs,
  config,
  lib,
  homedir,
  system ? null,
  ...
}:
{
  imports = [
    ./packages.nix
  ];

  home.stateVersion = "25.11";
  programs.home-manager.enable = true;

  programs.fish.enable = true;
}

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
    (import ./programs {
      inherit
        pkgs
        lib
        config
        system
        ;
    })

    ./packages.nix
  ];

  home.stateVersion = "25.11";
  programs.home-manager.enable = true;
}

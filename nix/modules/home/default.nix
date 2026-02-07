{
  pkgs,
  config,
  lib,
  homedir,
  dotfilesDir ? "${homedir}/ghq/github.com/aiwao/dotfiles",
  system ? null,
  ...
}:
let
  helpers = import ../lib/helpers { inherit lib; };
in
{
  imports = [
    (import ./programs {
      inherit
        pkgs
        lib
        config
        system
        helpers
        ;
    })

    (import ./dotfiles.nix) {
      inherit
        pkgs
        lib
        config
        dotfilesDir
        helpers
        ;
    }

    ./packages.nix
  ];

  home.stateVersion = "25.11";
  programs.home-manager.enable = true;
}

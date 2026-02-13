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
  _module.args = {
    inherit helpers dotfilesDir system homedir;
  };

  imports = [
    ./packages.nix

    ./dotfiles.nix

    (import ./programs {
      inherit
        pkgs
        config
        lib
        homedir
        dotfilesDir
        system
        helpers
        ;
    }) 
  ];

  home.stateVersion = "25.11";
  programs.home-manager.enable = true;
}

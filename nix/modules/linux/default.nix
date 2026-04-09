{
  pkgs,
  config,
  lib,
  homedir,
  dotfilesDir ? "${homedir}/ghq/github.com/aiwao/dotfiles",
  helpers,
  ...
}:
{
  imports = [
    ./packages.nix
    ./dotfiles.nix
    ./systemd.nix
    (import ./programs {
      inherit
        pkgs
        config
        lib
        homedir
        dotfilesDir
        helpers
        ;
    })
  ];

  programs.nix-index.enable = true;
  programs.nix-index-database.comma.enable = true;
}

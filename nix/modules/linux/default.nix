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
    ./startup.nix
  ];

  programs.nix-index.enable = true;
  programs.nix-index-database.comma.enable = true;
}

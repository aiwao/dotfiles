{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    ./fish.nix
    ./neovim.nix
  ];
}

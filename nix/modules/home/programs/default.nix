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
    ./bat.nix
    ./direnv.nix
  ];
}

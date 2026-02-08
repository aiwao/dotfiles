{
  pkgs,
  lib,
  config,
  dotfilesDir,
  helpers,
  ...
}:
{
  imports = [
    ./fish.nix
    ./bat.nix
    ./direnv.nix
    ./neovim.nix
  ];
}

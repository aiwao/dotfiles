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
    ./neovim.nix
    ./bat.nix
    ./direnv.nix
  ];
}

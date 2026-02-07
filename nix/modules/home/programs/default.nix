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
    (import ./neovim.nix {
      inherit
        pkgs
        lib
        config
        dotfilesDir
        helpers
        ;
    })
  ];
}

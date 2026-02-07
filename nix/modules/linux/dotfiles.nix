{
  pkgs,
  lib,
  config,
  dotfilesDir ? "${config.home.homeDirectory}/ghq/github.com/aiwao/dotfiles",
  helpers,
  ...
}:
let
  inherit (config.xdg) configHome;
in
{ 
  # Linux-specific dotfile symlinks
  home.activation.linkDotfilesLinux = lib.hm.dag.entryAfter [ "linkGeneration" ] (
    lib.optionalString (!pkgs.stdenv.isDarwin) ''
      ${helpers.activation.mkLinkForce}
    ''
  );
}

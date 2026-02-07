{
  pkgs,
  lib,
  config,
  dotfilesDir ? "${config.home.homeDirectory}/ghq/github.com/aiwao/dotfiles",
  helpers,
  ...
}:
let
  inherit (config.home) homeDirectory;
  inherit (config.xdg) configHome;
in
{
  # macOS-specific dotfile symlinks
  home.activation.linkDotfilesDarwin = lib.hm.dag.entryAfter [ "linkGeneration" ] (
    lib.optionalString pkgs.stdenv.isDarwin ''
        ${helpers.activation.mkLinkForce}
    ''
  );
}

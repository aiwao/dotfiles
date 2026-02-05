{ pkgs, lib, ... }:
let
  # Check if we're on a platform that supports certain packages
  inherit (pkgs.stdenv) isDarwin isLinux;
  isX86Linux = pkgs.stdenv.hostPlatform.system == "x86_64-linux";
in
{
  home.packages =
    with pkgs;
    [
      neovim
      wezterm
      curl
      devenv
      tmux
      git
      git-lfs
      ripgrep
      fd
      fzf
      wezterm
      jq
      nodejs_24
      bun
    ];
}

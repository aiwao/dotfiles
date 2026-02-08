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
      fish
      curl
      devenv
      htop
      tmux
      git
      git-lfs
      gh
      ghq
      ripgrep
      fd
      fzf
      jq
      bat
      delta
      eza
      zoxide
      nodejs_24
      bun
    ];
}

{ pkgs, lib, ... }:
let
  # Check if we're on a platform that supports certain packages
  inherit (pkgs.stdenv) isDarwin isLinux;
  isX86Linux = pkgs.stdenv.hostPlatform.system == "x86_64-linux";
  jdk21Pkg = pkgs.jdk21;
in
{
  home.packages =
    with pkgs;
    [
      jdk21Pkg
      uv
      mullvad
      roots
      wezterm
      zsh
      fish
      curl
      devenv
      htop
      tmux
      git
      git-wt
      git-now
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
      pnpm
    ];

    home.sessionVariables = {
      JDK21 = jdk21Pkg;
    };
}

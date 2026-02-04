{ pkgs, ... }:
{
  home.packages = with pkgs; [
    neovim-nightly-overlay
  ];
}

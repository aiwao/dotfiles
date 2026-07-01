{ pkgs, ... }:
{
  home.packages = with pkgs; [
    cemu
    rustdesk
    gimp
    vlc
    nixgl.nixGLIntel
  ];
}

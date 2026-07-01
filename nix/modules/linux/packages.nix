{ pkgs, ... }:
{
  home.packages = with pkgs; [
    rustdesk
    gimp
    vlc
    nixgl.nixGLIntel
  ];
}

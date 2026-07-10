{ pkgs, ... }:
{
  home.packages = with pkgs; [
    xclip
    rustdesk
    gimp
    vlc
    nixgl.nixGLIntel
  ];
}

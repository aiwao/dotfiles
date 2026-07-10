{ pkgs, ... }:
{
  home.packages = with pkgs; [
    android-studio-full
    xclip
    rustdesk
    gimp
    vlc
    nixgl.nixGLIntel
  ];
}

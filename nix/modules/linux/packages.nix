{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gimp
    vlc
    nixgl.nixGLIntel
  ];
}

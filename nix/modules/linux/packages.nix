{ pkgs, lib, ... }:
{
  home.packages =
    with pkgs;
    lib.optionals (stdenv.hostPlatform.system == "x86_64-linux") [
      android-studio-full
    ]
    ++ [
      xclip
      rustdesk
      gimp
      vlc
      nixgl.nixGLIntel
    ];
}

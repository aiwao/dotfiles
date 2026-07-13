{ pkgs, lib, ... }:
let
  reaperWithPipeWireJack = pkgs.symlinkJoin {
    name = "reaper-with-pipewire-jack";
    paths = [ pkgs.reaper ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram "$out/bin/reaper" \
        --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath [ pkgs.pipewire.jack ]}"
    '';
  };
in
{
  home.packages =
    with pkgs;
    lib.optionals (stdenv.hostPlatform.system == "x86_64-linux") [
      android-studio-full
      glib.bin
      yabridge
      yabridgectl
    ]
    ++ [
      wine
      reaperWithPipeWireJack
      xclip
      rustdesk
      gimp
      vlc
      nixgl.nixGLIntel
    ];
}

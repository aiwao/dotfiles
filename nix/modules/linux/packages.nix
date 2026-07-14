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
  # GNOME needs an absolute TryExec path, and WezTerm must run through nixGL on Linux.
  xdg.desktopEntries."org.wezfurlong.wezterm" = {
    name = "WezTerm";
    genericName = "Terminal Emulator";
    comment = "Wez's Terminal Emulator";
    exec = "${pkgs.nixgl.nixGLIntel}/bin/nixGLIntel ${pkgs.wezterm}/bin/wezterm start --cwd .";
    icon = "org.wezfurlong.wezterm";
    terminal = false;
    categories = [
      "System"
      "TerminalEmulator"
      "Utility"
    ];
    settings = {
      Keywords = "shell;prompt;command;commandline;cmd;";
      StartupWMClass = "org.wezfurlong.wezterm";
      TryExec = "${pkgs.nixgl.nixGLIntel}/bin/nixGLIntel";
    };
  };

  home.packages =
    with pkgs;
    lib.optionals (stdenv.hostPlatform.system == "x86_64-linux") [
      android-studio-full
      glib.bin
      yabridge
      yabridgectl
      wine
    ]
    ++ [
      reaperWithPipeWireJack
      xclip
      rustdesk
      gimp
      vlc
      nixgl.nixGLIntel
    ];
}

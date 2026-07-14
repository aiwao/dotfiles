{ pkgs, ... }:
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
}

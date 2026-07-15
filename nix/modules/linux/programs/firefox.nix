{ config, pkgs, ... }:
let
  firefox = config.programs.firefox.finalPackage;
  nixGL = "${pkgs.nixgl.nixGLIntel}/bin/nixGLIntel";
  firefoxExec = "${nixGL} ${firefox}/bin/firefox";
in
{
  xdg.desktopEntries.firefox = {
    name = "Firefox";
    genericName = "Web Browser";
    comment = "Browse the Web";
    exec = "${firefoxExec} --name firefox %U";
    icon = "firefox";
    terminal = false;
    categories = [
      "Network"
      "WebBrowser"
    ];
    mimeType = [
      "text/html"
      "text/xml"
      "application/xhtml+xml"
      "application/vnd.mozilla.xul+xml"
      "x-scheme-handler/http"
      "x-scheme-handler/https"
    ];
    startupNotify = true;
    settings = {
      StartupWMClass = "firefox";
      TryExec = nixGL;
    };
    actions = {
      new-window = {
        name = "New Window";
        exec = "${firefoxExec} --new-window %U";
      };
      new-private-window = {
        name = "New Private Window";
        exec = "${firefoxExec} --private-window %U";
      };
      profile-manager-window = {
        name = "Profile Manager";
        exec = "${firefoxExec} --ProfileManager";
      };
    };
  };
}

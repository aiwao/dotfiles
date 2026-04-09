{ pkgs, ... }: {
  systemd.user.services = {
    wezterm = {
      Unit = {
        Description = "Terminal";
        After = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.nixgl.nixGLIntel}/bin/nixGLIntel ${pkgs.wezterm}/bin/wezterm";
        Restart = "on-failure";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}

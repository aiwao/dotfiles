{ pkgs, ... }: {
  launchd.agents = {
    wezterm = {
      enable = true;
      config = {
        ProgramArguments = [ "${pkgs.wezterm}/bin/wezterm" ];
        RunAtLoad = true;
        KeepAlive = false;
      };
    };
  };
}

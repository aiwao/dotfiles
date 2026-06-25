{
  pkgs,
  username,
  ...
}: {
  environment.etc = {
    subuid = {
      text = ''
        ${username}:100000:65536
      '';
      replaceExisting = true;
    };
    subgid = {
      text = ''
        ${username}:100000:65536
      '';
      replaceExisting = true;
    };
  };

  systemd.services.mullvad-daemon = {
    enable = true;
    description = "Mullvad VPN daemon";
    wantedBy = [ "multi-user.target" ];
    wants = [
      "network.target"
      "network-online.target"
    ];
    after = [
      "network-online.target"
      "NetworkManager.service"
      "systemd-resolved.service"
    ];
    startLimitBurst = 5;
    startLimitIntervalSec = 20;
    serviceConfig = {
      ExecStartPre = "-${pkgs.kmod}/bin/modprobe tun";
      ExecStart = "${pkgs.mullvad}/bin/mullvad-daemon -v --disable-stdout-timestamps";
      Restart = "always";
      RestartSec = 1;
    };
  };
}

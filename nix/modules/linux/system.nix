{
  pkgs,
  username,
  ...
}: {
  environment.etc = {
    "apparmor.d/nix-bwrap" = {
      text = ''
        abi <abi/4.0>,
        include <tunables/global>

        profile nix-bwrap ${pkgs.bubblewrap}/bin/bwrap flags=(unconfined) {
          userns,
        }
      '';
    };
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

  systemd.services.nix-bwrap-apparmor = {
    enable = true;
    description = "Allow user namespaces for Nix bubblewrap";
    wantedBy = [ "system-manager.target" ];
    after = [ "apparmor.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "/usr/sbin/apparmor_parser --replace /etc/apparmor.d/nix-bwrap";
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

{
  pkgs,
  username,
  ...
}:
let
  dockerDaemonConfig = (pkgs.formats.json { }).generate "docker-daemon.json" {
    group = "docker";
    hosts = [ "fd://" ];
    "log-driver" = "journald";
  };
in
{
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

  users.groups.docker.members = [ username ];

  systemd.sockets.docker = {
    enable = true;
    description = "Docker Socket for the API";
    wantedBy = [ "sockets.target" ];
    socketConfig = {
      ListenStream = [ "/run/docker.sock" ];
      SocketMode = "0660";
      SocketUser = "root";
      SocketGroup = "docker";
    };
  };

  systemd.services.docker = {
    enable = true;
    description = "Docker Application Container Engine";
    wantedBy = [ "multi-user.target" ];
    wants = [ "network-online.target" ];
    after = [
      "network-online.target"
      "docker.socket"
    ];
    requires = [ "docker.socket" ];
    path = [
      pkgs.apparmor-parser
      pkgs.kmod
    ];
    serviceConfig = {
      Type = "notify";
      ExecStart = "${pkgs.docker}/bin/dockerd --config-file=${dockerDaemonConfig}";
      ExecReload = "${pkgs.procps}/bin/kill -s HUP $MAINPID";
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

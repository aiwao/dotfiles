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

  security.wrappers.mullvad-vpn-sandbox = {
    setuid = true;
    owner = "root";
    group = "root";
    source = "${pkgs.electron}/libexec/electron/chrome-sandbox";
  };

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

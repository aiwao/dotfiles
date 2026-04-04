{ pkgs, ... }:
let
  # Provides a fake "docker" binary mapping to podman
  dockerCompat = pkgs.runCommandNoCC "docker-podman-compat" {} ''
    mkdir -p $out/bin
    ln -s ${pkgs.podman}/bin/podman $out/bin/docker
  '';
in
{
  home.packages = with pkgs; [
    dockerCompat
    podman
    runc
    conmon
    skopeo
    slirp4netns
    fuse-overlayfs
    podman-compose
    podman-tui
  ];
}

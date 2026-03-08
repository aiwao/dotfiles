{ pkgs, ... }:
{
  home.packages = with pkgs; [
    containerd
    docker
    docker-buildx
    docker-compose
  ];
}

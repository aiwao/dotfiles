{
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (config.xdg) configHome;
  
  registriesConf = pkgs.writeText "registries.conf" ''
      [registries.search]
      registries = ['docker.io']

      [registries.block]
      registries = []
    '';
in
{
  home.activation.setupPodman = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    # Dont overwrite customised configuration
    if ! test -f ${configHome}/containers/policy.json; then
      install -Dm555 ${pkgs.skopeo.src}/default-policy.json ${configHome}/containers/policy.json
    fi

    if ! test -f ${configHome}/containers/registries.conf; then
      install -Dm555 ${registriesConf} ${configHome}/containers/registries.conf
    fi
  '';
}

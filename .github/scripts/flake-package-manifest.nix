{ system }:
let
  root = ../..;
  flake = builtins.getFlake (toString root);
  inherit (flake.inputs) nixpkgs;
  lib = nixpkgs.lib;

  isDarwin = builtins.match ".*-darwin" system != null;
  isLinux = builtins.match ".*-linux" system != null;

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
    overlays =
      [
        flake.inputs.neovim-nightly-overlay.overlays.default
        (import ../../nix/overlays/default.nix)
      ]
      ++ lib.optionals isLinux [
        flake.inputs.nixgl.overlay
      ];
  };

  packageModules =
    [
      (import ../../nix/modules/home/packages.nix { inherit pkgs lib; })
    ]
    ++ lib.optionals isDarwin [
      (import ../../nix/modules/darwin/packages.nix { inherit pkgs lib; })
    ]
    ++ lib.optionals isLinux [
      (import ../../nix/modules/linux/packages.nix { inherit pkgs lib; })
    ];

  packages = lib.concatMap (module: module.home.packages or [ ]) packageModules;

  packageInfo = package: {
    name = lib.getName package;
    version = lib.getVersion package;
    drvName = package.name or (baseNameOf (toString package));
    drvPath = toString package.drvPath;
  };
in
{
  inherit system;
  packages = map packageInfo packages;
}

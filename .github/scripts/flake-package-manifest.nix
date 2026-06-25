{ system }:
let
  username = "aiwao";
  root = ../..;
  flake = builtins.getFlake (toString root);
  inherit (flake.inputs) home-manager nixpkgs;
  lib = nixpkgs.lib;

  isDarwin = builtins.match ".*-darwin" system != null;
  isLinux = builtins.match ".*-linux" system != null;
  homedir = if isDarwin then "/Users/${username}" else "/home/${username}";
  dotfilesDir = "${homedir}/ghq/github.com/aiwao/dotfiles";

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

  packages =
    (home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        flake.inputs.catppuccin.homeModules.catppuccin

        {
          home.username = username;
          home.homeDirectory = homedir;
        }

        (
          {
            config,
            lib,
            ...
          }:
          let
            helpers = import ../../nix/modules/lib/helpers { inherit lib; };
          in
          {
            imports =
              [
                (import ../../nix/modules/home {
                  inherit
                    pkgs
                    config
                    lib
                    ;
                  inherit homedir system dotfilesDir;
                })
              ]
              ++ lib.optionals isDarwin [
                (import ../../nix/modules/darwin {
                  inherit
                    pkgs
                    config
                    lib
                    helpers
                    ;
                  inherit homedir dotfilesDir;
                })
              ]
              ++ lib.optionals isLinux [
                flake.inputs.nix-index-database.hmModules.nix-index

                (import ../../nix/modules/linux {
                  inherit
                    pkgs
                    config
                    lib
                    helpers
                    ;
                  inherit homedir dotfilesDir;
                })
              ];

            # Theme assets are irrelevant to package version diffs and can force
            # platform-specific derivations during cross evaluation.
            catppuccin.enable = lib.mkForce false;
            catppuccin.bat.enable = lib.mkForce false;
            catppuccin.eza.enable = lib.mkForce false;
            catppuccin.fzf.enable = lib.mkForce false;
            catppuccin.zsh-syntax-highlighting.enable = lib.mkForce false;

            # The Firefox package should be listed, but this generated settings value
            # also forces a platform-specific catppuccin derivation.
            programs.firefox.profiles.default.extensions.settings."FirefoxColor@mozilla.com".settings =
              lib.mkForce { };
          }
        )
      ];
    }).config.home.packages;

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

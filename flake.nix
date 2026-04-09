{
  description = "nix config";

  nixConfig = {
    extra-substituters = [
      "https://cache.nixos.org"
      "https://cache.numtide.com"
      "https://devenv.cachix.org"
      "https://aiwao.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      "aiwao.cachix.org-1:b2LbtWNvJeL/qb1B6TYOMK+apaCps4SCbzlPRfSQIms="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    
    flake-parts.url = "github:hercules-ci/flake-parts";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    system-manager = {
      url = "github:numtide/system-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nixgl.url = "github:nix-community/nixGL";
  };

  outputs = 
    inputs@{
      self,
      nixpkgs,
      nix-darwin,
      flake-parts,
      home-manager,
      system-manager,
      nix-index-database,
      neovim-nightly-overlay,
      nixgl,
      ...
    }: 
    let
      username = "aiwao";
      darwinHomedir = "/Users/${username}";
      linuxHomedir = "/home/${username}";

      # Create pkgs with overlays
      mkPkgs =
        {
          system,
          extraOverlays ? [ ],
        }:
        let
          isDarwin = builtins.match ".*-darwin" system != null;
        in
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [
            neovim-nightly-overlay.overlays.default
            (import ./nix/overlays/default.nix)
          ]
          ++ extraOverlays;
        };

      # Helper to create Linux home configuration
      mkLinuxHomeConfig =
        linuxSystem:
        home-manager.lib.homeManagerConfiguration {
          pkgs = mkPkgs {
            system = linuxSystem;
            extraOverlays = [ nixgl.overlay ];
          };
          modules = [
            {
              home.username = username;
              home.homeDirectory = linuxHomedir;
            }
            (
              {
                pkgs,
                config,
                lib,
                ...
              }:
              let
                helpers = import ./nix/modules/lib/helpers { inherit lib; };
              in
              {
                imports = [
                  nix-index-database.hmModules.nix-index

                  (import ./nix/modules/home {
                    inherit
                      pkgs
                      config
                      lib
                      ;
                    homedir = linuxHomedir;
                    system = linuxSystem;
                  })

                  (import ./nix/modules/linux {
                    inherit
                      pkgs
                      config
                      lib
                      helpers
                      ;
                    homedir = linuxHomedir;
                    dotfilesDir = "${linuxHomedir}/ghq/github.com/aiwao/dotfiles";
                  })
                ];
              }
            )
          ];
        };

    mkLinuxSystemConfig =
      linuxSystem:
      system-manager.lib.makeSystemConfig {
        modules = [
          ({ ... }: {
            nixpkgs.hostPlatform = linuxSystem;
          })

          (import ./nix/modules/linux/system.nix {
            pkgs = mkPkgs { system = linuxSystem; };
            inherit (nixpkgs) lib;
            inherit username;
            homedir = linuxHomedir;
          })
        ];
      };
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "aarch64-darwin"
        "x86_64-linux"
        "aarch64-linux"
      ];

      perSystem =
        {
          config,
          system,
          ...
        }:
        let
          localPkgs = mkPkgs { system = system; };
          inherit (localPkgs.stdenv) isDarwin;
          homedir = if isDarwin then darwinHomedir else linuxHomedir;
          hostname = username;
        in
        {
          apps = {
            build = {
              type = "app";
              program = toString (
                localPkgs.writeShellScript (if isDarwin then "darwin-build" else "home-manager-build") ''
                  set -e
                  echo "Building ${if isDarwin then "darwin" else "Home Manager"} configuration..."
                  nix build .#${
                    if isDarwin then
                      "darwinConfigurations.${hostname}.system"
                    else
                      "homeConfigurations.${username}.activationPackage"
                  }
                  echo "Build successful! Run 'nix run .#switch' to apply."
                ''
              );
            };

            switch = {
              type = "app";
              program = toString (
                localPkgs.writeShellScript (if isDarwin then "darwin-switch" else "home-manager-switch") ''
                  set -e
                  echo "Building and switching to ${if isDarwin then "darwin" else "Home Manager"} configuration..."
                  ${
                    if isDarwin then
                      ''
                        sudo nix run nix-darwin -- switch --flake .#${hostname}
                      ''
                    else
                      ''
                        nix run nixpkgs#home-manager -- switch --flake .#${username}
                      ''
                  }
                  echo "Clearing fish cache..."
                  rm -rf "$TMPDIR/fish-cache"
                  echo "Done!"
                ''
              );
            };

            update = {
              type = "app";
              program = toString (
                localPkgs.writeShellScript "flake-update" ''
                  set -e
                  echo "Updating flake.lock..."
                  nix flake update
                  echo "Done! Run 'nix run .#switch' to apply changes."
                ''
              );
            };
          };
        };

        flake = {
          # macOS configuration with nix-darwin
          darwinConfigurations.${username} = nix-darwin.lib.darwinSystem {
            system = "aarch64-darwin";

            modules = [
              (import ./nix/modules/darwin/system.nix {
                pkgs = mkPkgs { system = "aarch64-darwin"; };
                inherit (nixpkgs) lib;
                inherit username;
                homedir = darwinHomedir;
              })

              nix-index-database.darwinModules.nix-index

              home-manager.darwinModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = false;
                  useUserPackages = true;
                  extraSpecialArgs = {
                    pkgs = mkPkgs { system = "aarch64-darwin"; };
                  };
                  users.${username} =
                    {
                      pkgs,
                      config,
                      lib,
                      ...
                    }:
                    let
                      helpers = import ./nix/modules/lib/helpers { inherit lib; };
                    in
                    {
                      imports = [
                        (import ./nix/modules/home {
                          inherit
                            pkgs
                            config
                            lib
                            ;
                          homedir = darwinHomedir;
                          system = "aarch64-darwin";
                        })

                        (import ./nix/modules/darwin {
                          inherit
                            pkgs
                            config
                            lib
                            helpers
                            ;
                          homedir = darwinHomedir;
                          dotfilesDir = "${darwinHomedir}/ghq/github.com/aiwao/dotfiles";
                        })
                      ];
                    };
                };
              }
            ];
          };

          systemConfigs.${username} = system-manager.lib.makeSystemConfig {
            modules = [
              ({ ... }: {
                nixpkgs.hostPlatform = "x86_64-linux";
                system-manager.allowAnyDistro = true;
              })

              (import ./nix/modules/linux/system.nix {
                pkgs = mkPkgs { system = "x86_64-linux"; };
                inherit (nixpkgs) lib;
                inherit username;
                homedir = linuxHomedir;
              })
            ];
          };

          systemConfigs = {
            ${username} = mkLinuxSystemConfig "x86_64-linux";
            "${username}-aarch64" = mkLinuxSystemConfig "aarch64-linux";
          };

          # Linux configurations with standalone Home Manager
          homeConfigurations = {
            ${username} = mkLinuxHomeConfig "x86_64-linux";
            "${username}-aarch64" = mkLinuxHomeConfig "aarch64-linux";
          };
        };
    };
}

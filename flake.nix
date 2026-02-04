{
  description = "nix config";

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://aiwao.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "aiwao.cachix.org-1:dXEAaIYyizNQTorsQP0/ouGPiTzYsKsMbQvPuEoHeP8="
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
  };
  
  outputs = 
    inputs@{
      self,
      nixpkgs,
      flake-parts,
      nix-darwin,
      home-manager,
      ...
    }:
   
    flake-parts.lib.mkFlake { inherit inputs; } {
      # flake-parts の都合で systems を宣言（最低限これでOK）
      systems = [
        "aarch64-darwin"
        "x86_64-darwin"
        "x86_64-linux"
        "aarch64-linux"
      ];

      flake =
        let
          username = "aa";

          # ここはあなたの環境に合わせて
          macHost = "macbook";
          macSystem = "aarch64-darwin"; # Intel Macなら "x86_64-darwin"
          linuxHost = "linux";
          linuxSystem = "x86_64-linux"; # UbuntuがARMなら "aarch64-linux"
        in
        {
          # ----------------------------
          # Ubuntu (non-NixOS): home-manager
          # ----------------------------
          homeConfigurations."${username}@${linuxHost}" =
            home-manager.lib.homeManagerConfiguration {
              pkgs = import nixpkgs {
                system = linuxSystem;
                config.allowUnfree = true;
              };
              modules = [
                ./nix/home/common.nix

                # Ubuntu固有が必要なら ./home/ubuntu.nix を作ってここに追加
                # ./home/ubuntu.nix

                {
                  home.username = username;
                  home.homeDirectory = "/home/${username}";
                  home.stateVersion = "25.11";
                }
              ];
            };

          # ----------------------------
          # macOS: nix-darwin (+ home-manager 統合)
          # ----------------------------
          darwinConfigurations."${macHost}" =
            nix-darwin.lib.darwinSystem {
              system = macSystem;
              pkgs = import nixpkgs {
                system = macSystem;
                config.allowUnfree = true;
              };
              modules = [
                home-manager.darwinModules.home-manager
                {
                  # darwin 側の最低限
                  system.stateVersion = 5;

                  # ユーザー（必要に応じて）
                  users.users.${username}.home = "/Users/${username}";

                  # home-manager を darwin に統合
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;

                  home-manager.users.${username} = { ... }: {
                    imports = [
                      ./nix/home/common.nix

                      # macOS固有が必要なら ./home/macos.nix を作ってここに追加
                      # ./home/macos.nix
                    ];
                    home.stateVersion = "25.11";
                  };
                }
              ];
            };
        };
     };
  
}

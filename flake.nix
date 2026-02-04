{
  description = "nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { self, nixpkgs, darwin, neovim-nightly-overlay }:
    let
      system = "aarch64-darwin";

      pkgs = import nixpkgs {
        inherit system;
        overlays = [ neovim-nightly-overlay.overlays.default ];
      };
    in
    {
      darwinConfigurations."macbook" = darwin.lib.darwinSystem {
        inherit system pkgs;

        modules = [
          ({ pkgs, ... }: {
            system.stateVersion = 6;
            environment.systemPackages = with pkgs; [
              git
              curl
              nixfmt-rfc-style
              neovim
            ];
          })
        ];
      };
    };
}


{ system }:
let
  username = "aiwao";
  flake = builtins.getFlake (toString ../..);
  isDarwin = builtins.match ".*-darwin" system != null;

  packages =
    if isDarwin then
      flake.darwinConfigurations.${username}.config.home-manager.users.${username}.home.packages
    else
      flake.homeConfigurations."${username}-${system}".config.home.packages;

  packageInfo = package: {
    name = flake.inputs.nixpkgs.lib.getName package;
    version = flake.inputs.nixpkgs.lib.getVersion package;
    drvName = package.name or (baseNameOf (toString package));
    drvPath = toString package.drvPath;
  };
in
{
  inherit system;
  packages = map packageInfo packages;
}

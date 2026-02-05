{
  pkgs,
  username,
  homedir,
  ...
}:
let
  fishPath = "${pkgs.fish}/bin/fish";
in
{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Disable nix-darwin's Nix management (using Determinate Nix)
  # Note: Nix settings are managed via /etc/nix/nix.custom.conf instead
  # This file should be manually configured with trusted-users and substituters
  nix.enable = false;

  system = {
    # Set system state version
    stateVersion = 5;

    # Set primary user for homebrew
    primaryUser = username;

    # Set user shell on activation
    activationScripts.postActivation.text = ''
      echo "Setting login shell to fish..."
      sudo chsh -s ${fishPath} ${username} || true

      # Remove quarantine attribute from Arto.app (third-party tap)
      if [ -e "/Applications/Arto.app" ]; then
        echo "Removing quarantine from Arto.app..."
        xattr -dr com.apple.quarantine /Applications/Arto.app 2>/dev/null || true
      fi
    '';

    # macOS system defaults
    defaults = {
      # Finder settings
      finder = {
        AppleShowAllExtensions = true; # Show all file extensions
        AppleShowAllFiles = true; # Show hidden files
        ShowPathbar = true; # Show path bar
        ShowStatusBar = true; # Show status bar
        FXEnableExtensionChangeWarning = false; # Disable extension change warning
        FXPreferredViewStyle = "Nlsv"; # List view by default
      };

      screencapture = {
        location = "~/Pictures/Screenshots";
        type = "png";
      };
    };
  };

  users.users.${username} = {
    home = homedir;
    shell = pkgs.fish;
    ignoreShellProgramCheck = true;
  };

  environment.shells = [ pkgs.fish ];
}

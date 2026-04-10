{
  pkgs,
  username,
  homedir,
  ...
}:
let
  zshPath = "${pkgs.zsh}/bin/zsh";
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
      sudo chsh -s ${zshPath} ${username} || true
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
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
  };

  environment.shells = [ pkgs.zsh ];

  programs.nix-index.enable = true;
  programs.nix-index-database.comma.enable = true;

  launchd.agents = {
    wezterm = {
      serviceConfig = {
        ProgramArguments = [ "${pkgs.wezterm}/bin/wezterm" ];
        RunAtLoad = true;
        KeepAlive = false;
      };
    };
  };
}

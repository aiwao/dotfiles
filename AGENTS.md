# AGENTS.md

## Project Overview

- This repository contains personal dotfiles for the `aiwao` user.
- `flake.nix` is the main entry point for managing macOS and Linux development
  environments with Nix.
- macOS is managed with nix-darwin and Home Manager. Linux is managed with Home
  Manager and system-manager.
- Hand-authored configuration files live in this repository and are symlinked
  into the home directory or XDG paths by Home Manager activation scripts.
- For directory-specific editing guidance and validation steps, read the
  `AGENTS.md` file in each relevant subdirectory.

## Project File Structure

- `flake.nix`: flake inputs, overlays, app commands, and macOS/Linux
  configuration definitions.
- `flake.lock`: lock file for flake inputs.
- `README.md`: basic setup, build, switch, and update instructions.
- `nix/`: Nix configuration for Home Manager, nix-darwin, system-manager, and
  overlays.
- `nvim/`: active Neovim configuration.
- `nvim0.11.5/`: version-pinned or legacy Neovim configuration.
- `zsh/`: Zsh environment variables and sourced scripts.
- `wezterm/`: WezTerm Lua configuration.
- `bash/`: Bash profile and rc configuration.
- `efm-langserver/`: EFM Language Server configuration.
- `.cobra.yaml`: cobra-cli configuration.

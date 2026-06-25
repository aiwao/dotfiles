# AGENTS.md

## Scope

This file applies to Zsh configuration under `zsh/`.

## Directory Overview

- `.zshenv`: environment setup linked into the user's home directory.
- `scripts/`: Zsh scripts sourced by the Home Manager Zsh module.
- `zshrc_is_managed_by_home_manager`: marker/documentation file.

## Change Guidelines

- Edit repository files, not linked files under the user's home directory.
- Keep environment variables and early shell setup in `.zshenv`.
- Put reusable interactive helpers in `scripts/`.
- Home Manager sources every file under `${HOME}/.zsh/scripts/*`; avoid adding
  non-Zsh files there.
- Zsh plugins and common init behavior are managed in
  `nix/modules/home/programs/zsh.nix`.

## Validation

- Run `zsh -n` on changed `.zsh` files and sourced Zsh scripts when Zsh is
  available.
- If behavior depends on Home Manager setup, validate the related Nix change
  from the repository root with `nix run .#build`.

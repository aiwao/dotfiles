# AGENTS.md

## Scope

This file applies to Zsh configuration under `zsh/`.

## Directory Overview

- `scripts/`: Zsh scripts sourced by the Home Manager Zsh module.

## Change Guidelines

- Edit repository files, not linked files under the user's home directory.
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

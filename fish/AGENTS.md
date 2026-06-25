# AGENTS.md

## Scope

This file applies to Fish shell configuration under `fish/`.

## Directory Overview

- `config.fish`: main Fish startup file.
- `config/`: user config snippets sourced by `config.fish`.
- `functions/`: autoloaded Fish functions.
- `themes/`: Fish theme files.
- `completions/` and `conf.d/`: Fish completion and startup snippet locations.

## Change Guidelines

- Edit repository files, not the linked destination under `~/.config/fish`.
- Keep reusable commands in `functions/`.
- Keep startup snippets in `config/`, `conf.d/`, or `config.fish` depending on
  the existing pattern.
- Fish plugins are managed from `nix/modules/home/programs/fish.nix`; do not
  vendor plugin output into this directory.
- Use idiomatic Fish syntax instead of Bash/Zsh syntax.

## Validation

- Run `fish -n` on changed `.fish` files when Fish is available.
- For changes that depend on Nix-managed plugins or PATH entries, validate the
  corresponding Nix module from the repository root with `nix run .#build`.

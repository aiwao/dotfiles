# AGENTS.md

## Scope

This file applies to EFM Language Server configuration under
`efm-langserver/`.

## Directory Overview

- `config.yaml`: EFM Language Server configuration linked into
  `~/.config/efm-langserver`.

## Change Guidelines

- Edit repository files, not the linked destination under
  `~/.config/efm-langserver`.
- Keep formatter and linter command names aligned with packages provided by
  `nix/modules/home/programs/neovim.nix` or other Nix modules.
- Preserve YAML indentation and avoid ad hoc string formatting.

## Validation

- Validate YAML syntax when possible.
- If adding a formatter or linter dependency, update the corresponding Nix
  module and run `nix run .#build` from the repository root.

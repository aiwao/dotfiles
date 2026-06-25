# AGENTS.md

## Scope

This file applies to the active Neovim configuration under `nvim/`.

## Directory Overview

- `init.lua`: entry point. It adds plugins with `vim.pack.add` and requires
  plugin/config modules.
- `lua/aiwao/plugin/`: plugin setup modules.
- `lua/aiwao/config/`: editor options, keymaps, diagnostics, dashboard, and
  shared UI behavior.
- `lua/aiwao/lsp/`: language-server configuration.
- `ftplugin/`: filetype-specific settings.
- `nvim-pack-lock.json`: Neovim plugin lock file.
- `types.lua`: local Lua type helpers or annotations.

## Change Guidelines

- This is the active config linked by `nix/modules/home/programs/neovim.nix`.
- Keep plugin setup in `lua/aiwao/plugin/` and general editor behavior in
  `lua/aiwao/config/`.
- Keep language-server behavior in `lua/aiwao/lsp/` when the change is LSP
  specific.
- Update `nvim-pack-lock.json` only when intentionally changing plugin
  versions.
- Follow the existing Lua style: two-space indentation and direct
  `require(...)` calls.

## Validation

- At minimum, syntax-check changed Lua files when possible.
- If practical, start Neovim headlessly to catch load errors after config
  changes.
- For package or language-server availability changes, update the relevant Nix
  module and validate from the repository root with `nix run .#build`.

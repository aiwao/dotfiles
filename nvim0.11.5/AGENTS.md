# AGENTS.md

## Scope

This file applies to `nvim0.11.5/`.

## Directory Overview

- `init.lua`: entry point for this versioned Neovim configuration.
- `lua/config/`: shared editor configuration for this config tree.
- `lua/plugins/`: plugin setup modules.
- `lazy-lock.json`: plugin lock file for this config tree.

## Change Guidelines

- Treat this as a versioned or legacy Neovim configuration.
- Do not change files here unless the task explicitly targets `nvim0.11.5/`.
- Update `lazy-lock.json` only when intentionally changing plugin versions for
  this tree.
- Follow the existing Lua style in nearby files.

## Validation

- Syntax-check changed Lua files when possible.
- If practical, load this config with the intended Neovim version to catch
  startup errors.

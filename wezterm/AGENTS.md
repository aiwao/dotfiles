# AGENTS.md

## Scope

This file applies to WezTerm configuration under `wezterm/`.

## Directory Overview

- `wezterm.lua`: main WezTerm configuration entry point.
- `keymaps.lua`: key binding definitions required by `wezterm.lua`.

## Change Guidelines

- Edit repository files, not the linked destination under `~/.config/wezterm`.
- Keep key bindings in `keymaps.lua` unless a setting must live in
  `wezterm.lua`.
- Follow the existing Lua style.
- Keep macOS-specific behavior explicit when adding platform-dependent
  settings.

## Validation

- Syntax-check changed Lua files when possible.
- If WezTerm is available, use its config validation facilities or start it
  after the user asks to apply/test the live configuration.

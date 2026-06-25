# AGENTS.md

This file gives coding agents project-specific guidance for this dotfiles
repository. It applies to the whole repository unless a more specific
`AGENTS.md` is added in a subdirectory.

## Project Overview

- This is a personal dotfiles repository for user `aiwao`.
- The main entry point is `flake.nix`.
- Nix is used to manage:
  - nix-darwin configuration for macOS.
  - Home Manager configuration for macOS and Linux.
  - system-manager configuration for Linux system-level settings.
- Hand-authored dotfiles live in directories such as `nvim/`, `fish/`, `zsh/`,
  `wezterm/`, `bash/`, and `efm-langserver/`.
- Home Manager activation scripts symlink those source directories into the
  user's home directory. Edit the repository sources, not the generated or
  symlinked destinations under `~/.config` or `~`.

## Important Paths

- `flake.nix`: flake inputs, overlays, app commands, and platform
  configurations.
- `nix/modules/home/`: common Home Manager modules.
- `nix/modules/home/programs/`: program-specific Home Manager modules.
- `nix/modules/darwin/`: macOS-specific modules.
- `nix/modules/linux/`: Linux-specific modules.
- `nix/modules/lib/helpers/`: shared Nix helper functions.
- `nix/overlays/`: local package overlays.
- `nvim/`: active Neovim configuration linked by
  `nix/modules/home/programs/neovim.nix`.
- `nvim0.11.5/`: versioned or legacy Neovim configuration. Do not change it
  unless the task explicitly targets it.
- `fish/`, `zsh/`, `wezterm/`, `bash/`, `efm-langserver/`: shell and tool
  configs linked by Home Manager activation.

## Commands

Use the commands below from the repository root.

- Build/test the current configuration:

  ```sh
  nix run .#build
  ```

- Apply the configuration to the current machine:

  ```sh
  nix run .#switch
  ```

- Update flake inputs:

  ```sh
  nix run .#update
  ```

- Initial macOS switch command from the README:

  ```sh
  sudo nix run nix-darwin -- switch --flake .#aiwao
  ```

Do not run `nix run .#switch`, the direct nix-darwin switch command, or other
commands that change the user's live system unless the user explicitly asks for
that. Prefer `nix run .#build` for validation.

Nix flakes ignore untracked files. If validation depends on a newly added file,
make sure the file is visible to Git before relying on a Nix build result.

## Change Guidelines

- Keep common user-level configuration in `nix/modules/home/`.
- Put platform-specific behavior in `nix/modules/darwin/` or
  `nix/modules/linux/`.
- Add new Home Manager program modules under `nix/modules/home/programs/` and
  import them from `nix/modules/home/programs/default.nix`.
- Add common packages to `nix/modules/home/packages.nix` when they should be
  available on all supported platforms.
- Add platform-only packages to the corresponding platform module.
- Keep the existing hard-coded username and home directory conventions unless
  the user asks to generalize them.
- Do not update `flake.lock` unless the task is specifically about dependency
  or package input updates.
- Treat `nvim/nvim-pack-lock.json` and `nvim0.11.5/lazy-lock.json` as lock
  files. Update them only when intentionally changing Neovim plugin versions.
- Avoid editing generated outputs, Nix build results, local caches, or
  `git-worktree/`.

## Style Notes

- Follow the local style in the file being edited.
- Nix files use two-space indentation and small modules with explicit imports.
- Lua files generally use two-space indentation and direct `require(...)`
  statements.
- Fish scripts use idiomatic Fish syntax; validate with `fish -n` when
  changing shell code.
- Zsh scripts should remain POSIX-aware only where the existing file already is;
  otherwise use normal Zsh syntax and validate with `zsh -n`.
- Keep comments useful and brief. Prefer explaining why a non-obvious setting
  exists over restating what the code says.

## Validation Checklist

Choose the smallest validation that matches the change:

- Nix module or package changes: run `nix run .#build`.
- Fish changes: run `fish -n` on changed `.fish` files when Fish is available.
- Zsh changes: run `zsh -n` on changed `.zsh` files or sourced Zsh files when
  Zsh is available.
- Lua/Neovim changes: at minimum check syntax for changed Lua files. If
  practical, start Neovim headlessly to catch load errors.
- Documentation-only changes: no build is required unless the documentation
  changes a Nix-visible file that should be checked.

If a validation command cannot be run because Nix or another tool is
unavailable, report that clearly with the reason.

## Safety

- Respect a dirty worktree. Do not revert, overwrite, or clean up changes you
  did not make unless the user explicitly asks.
- Do not use destructive Git or filesystem commands unless the user explicitly
  requests them.
- Do not add secrets, host-specific credentials, tokens, or private machine
  state to this repository.
- Be careful with activation scripts: they can remove and recreate user files
  through `link_force`. Review destination paths before changing link behavior.

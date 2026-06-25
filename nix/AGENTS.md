# AGENTS.md

## Scope

This file applies to files under `nix/`.

## Directory Overview

- `modules/home/`: common Home Manager modules.
- `modules/home/programs/`: program-specific Home Manager modules.
- `modules/darwin/`: macOS-specific nix-darwin and Home Manager modules.
- `modules/linux/`: Linux-specific Home Manager and system-manager modules.
- `modules/lib/helpers/`: shared helper functions used by modules.
- `overlays/`: local package overlays.
- `cachix.nix`: Cachix-related configuration.

## Change Guidelines

- Keep common user-level configuration in `modules/home/`.
- Put platform-specific behavior in `modules/darwin/` or `modules/linux/`.
- Add new Home Manager program modules under `modules/home/programs/` and
  import them from `modules/home/programs/default.nix`.
- Add common packages to `modules/home/packages.nix` when they should be
  available on all supported platforms.
- Add platform-only packages to the corresponding platform module.
- Keep the existing hard-coded username and home directory conventions unless
  the user asks to generalize them.
- Do not update `../flake.lock` unless the task is specifically about
  dependency or package input updates.
- Be careful with activation scripts: helpers such as `link_force` can remove
  and recreate user files. Review destination paths before changing link
  behavior.

## Validation

- Run from the repository root:

  ```sh
  nix run .#build
  ```

- Do not run `nix run .#switch`, direct nix-darwin switch commands, or other
  live system-changing commands unless the user explicitly asks.
- Nix flakes ignore untracked files. If validation depends on a newly added
  file, make sure it is visible to Git before relying on the build result.

# AGENTS.md

## Scope

This file applies to Bash configuration under `bash/`.

## Directory Overview

- `.bash_profile`: login shell profile linked into the user's home directory.
- `.bashrc`: interactive Bash configuration linked into the user's home
  directory.

## Change Guidelines

- Edit repository files, not linked files under the user's home directory.
- Keep login-only behavior in `.bash_profile`.
- Keep interactive shell behavior in `.bashrc`.
- Avoid moving Zsh-specific setup into Bash files.

## Validation

- Run `bash -n` on changed Bash files when Bash is available.

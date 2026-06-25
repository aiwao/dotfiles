# AGENTS.md

## プロジェクト概要

- このリポジトリは `aiwao` ユーザー向けの個人 dotfiles です。
- `flake.nix` を入口に、Nix で macOS と Linux の開発環境を管理します。
- macOS は nix-darwin と Home Manager、Linux は Home Manager と
  system-manager を使います。
- 手書きの設定ファイルはリポジトリ内に置き、Home Manager の activation
  でホームディレクトリや XDG 配下へ symlink します。
- ディレクトリ固有の編集方針や検証方法は、各ディレクトリ配下の
  `AGENTS.md` を参照してください。

## プロジェクトファイル構造

- `flake.nix`: flake inputs、overlays、app commands、macOS/Linux の構成定義。
- `flake.lock`: flake input のロックファイル。
- `README.md`: セットアップ、build、switch、update の基本手順。
- `nix/`: Home Manager、nix-darwin、system-manager、overlays の Nix 設定。
- `nvim/`: 現行の Neovim 設定。
- `nvim0.11.5/`: バージョン固定または旧世代の Neovim 設定。
- `fish/`: Fish shell 設定、関数、テーマ。
- `zsh/`: Zsh 環境変数と読み込み用スクリプト。
- `wezterm/`: WezTerm の Lua 設定。
- `bash/`: Bash の profile/rc 設定。
- `efm-langserver/`: EFM Language Server 設定。
- `.cobra.yaml`: cobra-cli 設定。

{
  pkgs,
  config,
  lib,
  homedir,
  ...
}:
let
  abbrFile = "${config.xdg.configHome}/zsh-abbr/user-abbreviations";
in
{
  programs.zsh = {
    enable = true;

    envExtra = ''
      export XDG_CONFIG_HOME="$HOME/.config"
      export XDG_DATA_HOME="$HOME/.local/share"
      export XDG_CACHE_HOME="$HOME/.cache"
      export XDG_STATE_HOME="$HOME/.local/state"

      export LC_ALL="en_US.UTF-8"

      export EDITOR=nvim
      export GIT_EDITOR=nvim
      export VISUAL=nvim
      export MANPAGER="nvim -c ASMANPAGER -"

      export PATH="$HOME/.local/bin:$PATH"
    '';

    plugins = [
      {
        name = "zsh-completions";
        inherit (pkgs.zsh-completions) src;
      }
      {
        name = "zsh-autosuggestions";
        inherit (pkgs.zsh-autosuggestions) src;
      }
      {
        name = "zsh-autosuggestions-abbreviations-strategy";
        inherit (pkgs.zsh-autosuggestions-abbreviations-strategy) src;
      }
      {
        name = "zsh-fzf-tab";
        inherit (pkgs.zsh-fzf-tab) src;
      }
      {
        name = "zsh-syntax-highlighting";
        inherit (pkgs.zsh-syntax-highlighting) src;
      }
      {
        name = "zsh-autopair";
        inherit (pkgs.zsh-autopair) src;
      }
      {
        name = "zsh-nix-shell";
        inherit (pkgs.zsh-nix-shell) src;
      }
      {
        name = "zsh-abbr";
        inherit (pkgs.zsh-abbr) src;
      }
    ];

    initContent = ''
      foreach file (${homedir}/.zsh/scripts/*) {
        source $file
      }

      fpath+=("${pkgs.pure-prompt}/share/zsh/site-functions")
      autoload -U promptinit; promptinit
      prompt pure

      alias ls=eza

      eval "$(zoxide init zsh)"
      eval "$(direnv hook zsh)"
    '';
  };

  catppuccin.zsh-syntax-highlighting.enable = true;

  home.file."./.zshenv".force = true;

  home.activation.zshAbbr = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    export HOME=${lib.escapeShellArg config.home.homeDirectory}
    export XDG_CONFIG_HOME=${lib.escapeShellArg config.xdg.configHome}
    export ABBR_USER_ABBREVIATIONS_FILE=${lib.escapeShellArg abbrFile}

    run mkdir -p "$(${pkgs.coreutils}/bin/dirname "$ABBR_USER_ABBREVIATIONS_FILE")"
    run ${pkgs.zsh}/bin/zsh -f -c ${lib.escapeShellArg ''
      source ${pkgs.zsh-abbr}/share/zsh/zsh-abbr/zsh-abbr.zsh
      abbr --force --quieter "ll=ls -hl"
      abbr --force --quieter "la=ls -hAl"
      abbr --force --quieter "lt=ls --tree"
    ''}
  '';
}

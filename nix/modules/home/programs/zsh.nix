{
  pkgs,
  lib,
  homedir,
  ...
}:
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
    ${pkgs.zsh}/bin/zsh -c "
      source ${pkgs.zsh-abbr}/share/zsh/zsh-abbr/zsh-abbr.zsh && (
        abbr ll='ls -hl' || true;
        abbr la='ls -hAl' || true;
        abbr lt='ls --tree' || true;
      )
    "
  '';
}

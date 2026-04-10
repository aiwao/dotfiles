{
  pkgs,
  lib,
  homedir,
  ...
}:
{
  programs.zsh = {
    enable = true;
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
      source ${homedir}/.bash_profile
      
      foreach file (${homedir}/*) {
        source $file
      }

      fpath+=("${pkgs.pure-prompt}/share/zsh/site-functions")
      autoload -U promptinit; promptinit
      prompt pure

      alias ls=eza
    '';
  };

  catppuccin.zsh-syntax-highlighting.enable = true;

  home.activation.zshAbbr = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.zsh}/bin/zsh -c "
      source ${pkgs.zsh-abbr}/share/zsh/zsh-abbr/zsh-abbr.zsh && (
        abbr ll='ls -hl';
        abbr la='ls -hAl';
        abbr lt='ls --tree';
      )
    "
  '';
}

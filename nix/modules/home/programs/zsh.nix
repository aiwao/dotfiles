{
  pkgs,
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
    ];

    initContent = ''
      source ~/.bash_profile
      fpath+=("${pkgs.pure-prompt}/share/zsh/site-functions")
      autoload -U promptinit; promptinit
      prompt pure
    '';
  };
}

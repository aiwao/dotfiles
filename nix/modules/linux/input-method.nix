{
  config,
  pkgs,
  ...
}:
let
  fcitx5Package = config.i18n.inputMethod.package;
  fcitx5Profile = (pkgs.formats.ini { }).generate "fcitx5-profile" {
    GroupOrder."0" = "Default";
    "Groups/0" = {
      Name = "Default";
      "Default Layout" = "jp";
      DefaultIM = "mozc";
    };
    "Groups/0/Items/0".Name = "keyboard-jp";
    "Groups/0/Items/1".Name = "mozc";
  };
in
{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = [ pkgs.fcitx5-mozc ];
  };

  # Keep the mutable Fcitx5 configuration directory while managing the input
  # method list declaratively.
  xdg.configFile."fcitx5/profile" = {
    force = true;
    source = fcitx5Profile;
  };

  # Ubuntu's im-config sources this file twice: first to set environment
  # variables and later to start the selected input method. Home Manager owns
  # the Fcitx5 systemd service, so only set variables here to avoid starting the
  # distribution-provided daemon as well.
  home.file.".xinputrc" = {
    force = true;
    text = ''
      if [ "''${IM_CONFIG_PHASE:-}" = 1 ]; then
        XMODIFIERS=@im=fcitx
        GTK_IM_MODULE=fcitx
        QT_IM_MODULE=fcitx
        CLUTTER_IM_MODULE=xim
        SDL_IM_MODULE=fcitx
        QT_PLUGIN_PATH="${fcitx5Package}/${pkgs.qt6.qtbase.qtPluginPrefix}''${QT_PLUGIN_PATH:+:$QT_PLUGIN_PATH}"
      fi
    '';
  };
}

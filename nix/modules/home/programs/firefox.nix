{ homedir, lib, ... }: {
  programs.firefox = {
    enable = true;

    languagePacks = [ "ja" ];

    policies = {
      # Updates & Background Services
      AppAutoUpdate                 = false;
      BackgroundAppUpdate           = false;

      # Feature Disabling
      DisableBuiltinPDFViewer       = true;
      DisableFirefoxStudies         = true;
      DisableFirefoxAccounts        = true;
      DisableFirefoxScreenshots     = true;
      DisableForgetButton           = true;
      DisableMasterPasswordCreation = true;
      DisableProfileImport          = true;
      DisableProfileRefresh         = true;
      DisableSetDesktopBackground   = true;
      DisablePocket                 = true;
      DisableTelemetry              = true;
      DisableFormHistory            = true;
      DisablePasswordReveal         = true;

      # Access Restrictions
      BlockAboutConfig              = false;
      BlockAboutProfiles            = true;
      BlockAboutSupport             = true;

      # UI and Behavior
      DisplayMenuBar                = "never";
      DontCheckDefaultBrowser       = true;
      HardwareAcceleration          = false;
      OfferToSaveLogins             = false;
      DefaultDownloadDirectory      = "${homedir}/Downloads";

      # Extensions
      ExtensionSettings = let
        moz = short: "https://addons.mozilla.org/firefox/downloads/latest/${short}/latest.xpi";
      in {
        "*".installation_mode = "blocked";

        "uBlock0@raymondhill.net" = {
          install_url       = moz "ublock-origin";
          installation_mode = "force_installed";
          updates_disabled  = true;
        };

        "{60f82f00-9ad5-4de5-b31c-b16a47c51558}" = {
          install_url = moz "cookie-quick-manager";
          installation_mode = "force_installed";
          updates_disabled = true;
        };

        "firefox-extension@deepl.com" = {
          install_url = moz "deepl-translate";
          installation_mode = "force_installed";
          updates_disabled = true;
        };

        "wappalyzer@crunchlabz.com" = {
          install_url = moz "wappalyzer";
          installation_mode = "force_installed";
          updates_disabled = true;
        };
      };

      # Extension configuration 
      "3rdparty".Extensions = {
        "uBlock0@raymondhill.net".adminSettings = {
          userSettings = rec {
            uiTheme            = "dark";
            uiAccentCustom     = true;
            uiAccentCustom0    = "#8300ff";
            cloudStorageEnabled = lib.mkForce false;

            importedLists = [
              "https://filters.adtidy.org/extension/ublock/filters/3.txt"
              "https://github.com/DandelionSprout/adfilt/raw/master/LegitimateURLShortener.txt"
              "https://github.com/aiwao/my-ubo-filters/raw/main/youtube.txt"
            ];

            externalLists = lib.concatStringsSep "\n" importedLists;
          };

          selectedFilterLists = [
            "CZE-0"
            "adguard-generic"
            "adguard-annoyance"
            "adguard-social"
            "adguard-spyware-url"
            "easylist"
            "easyprivacy"
            "https://github.com/DandelionSprout/adfilt/raw/master/LegitimateURLShortener.txt"
            "https://github.com/aiwao/my-ubo-filters/raw/main/youtube.txt"
            "plowe-0"
            "ublock-abuse"
            "ublock-badware"
            "ublock-filters"
            "ublock-privacy"
            "ublock-quick-fixes"
            "ublock-unbreak"
            "urlhaus-1"
          ];
        };

        "wappalyzer@crunchlabz.com".tracking = false;
      };

      Bookmarks = [
        {
          Title = "Gmail";
          URL = "https://mail.google.com/mail/u/0/#inbox";
          Favicon = "https://ssl.gstatic.com/ui/v1/icons/mail/rfr/gmail.ico";
          Placement = "toolbar";
        }
      ];
    };
  };
}

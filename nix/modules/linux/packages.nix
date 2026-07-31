{ pkgs, lib, ... }:
let
  mullvadSandbox = "/run/wrappers/bin/mullvad-vpn-sandbox";
  mullvadElectron = pkgs.runCommand "mullvad-electron-${pkgs.electron.version}" { } ''
    mkdir -p "$out/bin"
    cp "${pkgs.electron}/bin/electron" "$out/bin/electron"
    chmod u+w "$out/bin/electron"

    store_sandbox="${pkgs.electron}/libexec/electron/chrome-sandbox"
    substituteInPlace "$out/bin/electron" \
      --replace-fail \
      "export CHROME_DEVEL_SANDBOX='$store_sandbox'" \
      "if [ -x '${mullvadSandbox}' ]; then export CHROME_DEVEL_SANDBOX='${mullvadSandbox}'; else export CHROME_DEVEL_SANDBOX='$store_sandbox'; fi"
  '';
  mullvadVpn = pkgs.symlinkJoin {
    name = "mullvad-vpn-${pkgs.mullvad-vpn.version}";
    paths = [ pkgs.mullvad-vpn ];
    postBuild = ''
      rm "$out/bin/mullvad-vpn"
      cp "${pkgs.mullvad-vpn}/bin/mullvad-vpn" "$out/bin/mullvad-vpn"
      chmod u+w "$out/bin/mullvad-vpn"

      substituteInPlace "$out/bin/mullvad-vpn" \
        --replace-fail \
        "${pkgs.electron}/bin/electron" \
        "${mullvadElectron}/bin/electron"
    '';
  };
  reaperWithPipeWireJack = pkgs.symlinkJoin {
    name = "reaper-with-pipewire-jack";
    paths = [ pkgs.reaper ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram "$out/bin/reaper" \
        --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath [ pkgs.pipewire.jack ]}"
    '';
  };
in
{
  home.packages =
    with pkgs;
    lib.optionals (stdenv.hostPlatform.system == "x86_64-linux") [
      glib.bin
      yabridge
      yabridgectl
      wine
    ]
    ++ [
      mullvadVpn
      reaperWithPipeWireJack
      xclip
      rustdesk
      gimp
      vlc
      nixgl.nixGLIntel
    ];
}

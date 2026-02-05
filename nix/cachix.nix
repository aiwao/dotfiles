let
  substituters = [
    "https://cache.nixos.org"
    "https://cache.numtide.com"
    "https://devenv.cachix.org"
    "https://aiwao.cachix.org"
  ];
  
  publicKeys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
    "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
    "aiwao.cachix.org-1:b2LbtWNvJeL/qb1B6TYOMK+apaCps4SCbzlPRfSQIms="
  ];
in
{
  inherit substituters publicKeys;

  flakeConfig = {
    extra-substituters = substituters;
    extra-trusted-public-keys = publicKeys;
  };
}

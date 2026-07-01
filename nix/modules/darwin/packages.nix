{ pkgs, ... }:
{
  home.packages =
    with pkgs;
    [
    ]
    ++ (with pkgs.brewCasks; [
      rustdesk
    ]);
}

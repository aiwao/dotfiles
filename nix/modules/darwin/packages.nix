{ pkgs, ... }:
{
  home.packages =
    with pkgs;
    [
      colima
    ]
    ++ (with pkgs.brewCasks; [
      rustdesk
    ]);
}

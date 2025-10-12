{ pkgs, lib, ... }:

{
  imports = [
    ./hyprland/default.nix
    ./gaming/default.nix
    ./navidrome/default.nix
    ./sunshine/default.nix

    ./quickshell/home.nix
    ./.themes/home.nix
    ./nemo/home.nix
  ];
}

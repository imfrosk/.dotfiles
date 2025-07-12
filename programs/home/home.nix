{ pkgs, lib, ... }:

{
  imports = [
    ./hyprland/home.nix
    ./.themes/home.nix
    ./ags/home.nix
  ];
}

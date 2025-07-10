{ pkgs, lib, ... }:

{
  imports = [
    ./hyprland/home.nix
    ./.themes/home.nix
  ];
}

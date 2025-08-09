{ config, pkgs, lib, ... }:

{
  imports = [
    ./quickshell/home.nix
    ./hyprland/home.nix
    ./.themes/home.nix
    ./nemo/home.nix
    #./zen/home.nix
  ];
}

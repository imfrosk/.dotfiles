{ pkgs, lib, ... }:

{
  imports = [
    ./hyprland/default.nix
    ./gaming/default.nix
  ];
}

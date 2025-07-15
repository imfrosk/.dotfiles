{ config, pkgs, inputs, lib, ... }:
with lib;
let
  cfg = config.hyprland;
in
{
  options.hyprland = {
    enable = mkEnableOption "Enable hyprland home configuration";
  };
  config = mkIf cfg.enable { 
    #services.hyprpaper.enable = true;
    #wayland.windowManager.hyprland.enable = true;
    home.file = {
    ".config/hypr/hyprland.conf" = {
      source = config.lib.file.mkOutOfStoreSymlink 
        "${config.home.homeDirectory}/.dotfiles/programs/home/hyprland/config/hypr.conf";
    };
  };
  };
}

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
    wayland.windowManager.hyprland = {
      enable = true;
      extraConfig = ''
        source = ~/.config/hypr/main.conf
      '';
      plugins = [
        inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprscrolling
        #inputs.hypr-dynamic-cursors.packages.${pkgs.system}.hypr-dynamic-cursors
      ];
    };
    #home.activation.hyprlandSymlink = ''
    #  ln -sfn "${config.home.homeDirectory}/.dotfiles/programs/home/hyprland/config/hypr.conf" \
    #    "${config.home.homeDirectory}/.config/hypr/hypr.conf"
    #'';
    home.file = {
    ".config/hypr/main.conf" = {
      source = config.lib.file.mkOutOfStoreSymlink 
        "${config.home.homeDirectory}/.dotfiles/programs/home/hyprland/config/hyprland.conf";
    };
    ".config/hypr/generated-windowrules.conf" = {
      source = config.lib.file.mkOutOfStoreSymlink 
        "${config.home.homeDirectory}/.dotfiles/programs/home/hyprland/config/generated-windowrules.conf";
    };
  };
  };
}

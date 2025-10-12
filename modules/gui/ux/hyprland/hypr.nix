{ pkgs, lib, config, inputs, myUser, ... }:
with lib;
let
  cfg = config.gui.ux.hyprland;
in
{
  options.gui.ux.hyprland = {
    enable = lib.mkEnableOption "Enables hyprland";
    uwsm = lib.mkEnableOption "Enables UWSM"; 
  };

  config = mkIf cfg.enable {
      environment.sessionVariables = {
        #_EGL_VENDOR_LIBRARY_FILENAMES = "${pkgs.mesa}/share/glvnd/egl_vendor.d/50_mesa.json";
        #WEBKIT_DISABLE_DMABUF_RENDERER = "1";
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
      };
      environment.sessionVariables.NIXOS_OZONE_WL = "1";
      programs.hyprland = {
        enable = true;
        xwayland.enable = true;
        package = inputs.hyprland.packages."${pkgs.system}".hyprland;
        withUWSM = mkIf cfg.uwsm true; 
      };

      environment.systemPackages = with pkgs; [
        hyprpolkitagent
      ];

      home-manager.users.${myUser} = { config, ... }: {
        wayland.windowManager.hyprland = {
          enable = true;
          extraConfig = ''
            source = ~/.config/hypr/main.conf
          '';
            plugins = [
              #inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprscrolling
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
                "${config.home.homeDirectory}/.dotfiles/modules/gui/ux/hyprland/config/hyprland.conf";
            };
            ".config/hypr/generated-windowrules.conf" = {
              source = config.lib.file.mkOutOfStoreSymlink 
                "${config.home.homeDirectory}/.dotfiles/modules/gui/ux/hyprland/config/generated-windowrules.conf";
            };
          };
      };
  };
}

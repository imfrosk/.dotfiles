{ pkgs, lib, config, inputs, ... }:
with lib;
let
  cfg = config.hyprland;
in
{
  options.hyprland = {
    enable = lib.mkEnableOption "Enables hyprland";
    uwsm = lib.mkEnableOption "Enables UWSM"; 
  };

  config = mkIf cfg.enable {
      environment.sessionVariables = {
        _EGL_VENDOR_LIBRARY_FILENAMES = "${pkgs.mesa}/share/glvnd/egl_vendor.d/50_mesa.json";
        WEBKIT_DISABLE_DMABUF_RENDERER = "1";
      };
      environment.sessionVariables.NIXOS_OZONE_WL = "1";
      programs.hyprland = {
        enable = true;
        xwayland.enable = true;
        package = inputs.hyprland.packages."${pkgs.system}".hyprland;
        withUWSM = mkIf cfg.uwsm true; 
      };
  };
  
}

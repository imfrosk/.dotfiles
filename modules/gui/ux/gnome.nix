{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.gui.ux.gnome;
in
{
  options.gui.ux.gnome = {
    enable = lib.mkEnableOption "Enables Gnome";
  };

  config = mkIf cfg.enable {
    services = { 
      displayManager.gdm.enable = true;
      desktopManager.gnome = {
        enable = true;
        extraGSettingsOverridePackages = [ pkgs.mutter ];
        extraGSettingsOverrides = ''
          [org.gnome.mutter]
          experimental-features=['scale-monitor-framebuffer']
        '';
      };
    };
    environment = {
      gnome.excludePackages = with pkgs; [
        epiphany
        #nautilus
      ];
      systemPackages = with pkgs; [
        gnome-tweaks
        gnome-randr
      ];
    };
  };
}

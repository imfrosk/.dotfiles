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
      desktopManager.gnome.enable = true;
      gnome = {
        core-developer-tools.enable = false;
        games.enable = false;
      };
    };
    environment.gnome.excludePackages = with pkgs; [
      epiphany
      nautilus
    ];
  };
}

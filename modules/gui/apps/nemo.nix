{ config, pkgs, lib, ...}:
let
  cfg = config.gui.apps.nemo;
in
{
  options.gui.apps.nemo = {
    enable = lib.mkEnableOption "Enables nemo (file manager)";
  };
  config = lib.mkIf cfg.enable {
    home-manager.sharedModules = [ {
      home.packages = with pkgs; [ nemo-with-extensions ffmpegthumbnailer ];
      xdg.desktopEntries.nemo = {
        name = "Nemo";
        exec = "${pkgs.nemo-with-extensions}/bin/nemo";
      };
      xdg.mimeApps = {
        enable = true;
        defaultApplications = {
            "inode/directory" = [ "nemo.desktop" ];
            "application/x-gnome-saved-search" = [ "nemo.desktop" ];
        };
      };
      dconf = {
        settings = {
            "org/cinnamon/desktop/applications/terminal" = {
                exec = "kitty";
            };
        };
      };
    } ];
  };
}

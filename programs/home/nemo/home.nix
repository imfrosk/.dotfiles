{ config, pkgs, ...}:

{
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
}

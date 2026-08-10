{ pkgs, lib, ... }: {
  home-manager.sharedModules = [ {
    home.pointerCursor = {
      enable = true;
      gtk.enable = true;
      package = pkgs.google-cursor;
      name = "GoogleDot-Black";
      size = 18;
    };
    qt.platformTheme.name = lib.mkForce "adwaita";
    gtk = {
      enable = true;
      iconTheme = {
        package = pkgs.gruvbox-dark-icons-gtk;
        name = "Gruvbox-Dark";
      };
      gtk3.extraConfig = {
        Settings = ''
          gtk-application-prefer-dark-theme=1
        '';
      };
      gtk4 = {
        theme = lib.mkForce null;
        extraConfig = {
          Settings = ''
            gtk-application-prefer-dark-theme=1
          '';
        };
      };
    };
  } ];
}

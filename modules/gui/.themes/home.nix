{ pkgs, ... }: {
  home-manager.sharedModules = [ {
    qt = {
        enable = true;
        platformTheme.name = "gtk";
    };
    home.pointerCursor = {
      gtk.enable = true;
      package = pkgs.google-cursor;
      name = "GoogleDot-Black";
      size = 18;
    };
    gtk = {
      enable = true;
      iconTheme = {
        package = pkgs.catppuccin-papirus-folders.override {
          flavor = "macchiato";
          accent = "lavender";
        };
        name = "Papirus-Dark";
      };
      theme = {
          name = "catppuccin-macchiato-mauve-compact";
          package = pkgs.catppuccin-gtk.override {
            accents = ["mauve"];
            variant = "macchiato";
            size = "compact";
          };
      };
      gtk3.extraConfig = {
        Settings = ''
          gtk-application-prefer-dark-theme=1
        '';
      };
      gtk4.extraConfig = {
        Settings = ''
          gtk-application-prefer-dark-theme=1
        '';
      };
    };
  } ];
}

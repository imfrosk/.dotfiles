{ config, pkgs, ... }:

{
  imports =
    [
      ./../../programs/home/home.nix
      ./../../programs/system/home.nix
    ];
  home.username = "frosk";
  home.homeDirectory = "/home/frosk";
  home.stateVersion = "25.05"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true; 

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      if uwsm check may-start; then
          exec uwsm start hyprland-uwsm.desktop
      fi
    '';
    shellAliases = {
      nano = "nixCats";
      v = "nixCats";
      vi = "nixCats";
      vim = "nixCats";
      ".." = "cd ..";
      la = "ls -la";
      fr = "sudo nixos-rebuild switch --flake /home/frosk/.dotfiles";
      hms = "home-manager switch --flake /home/frosk/.dotfiles";
      cdh = "cd /home/frosk/.dotfiles/hosts/frosk-nixos/";
      nix-alien = "nix run \"github:thiagokokada/nix-alien#nix-alien\" -- ";
    };
  };

  programs.mangohud = {
    enable = true;
    settings = {
     fps_limit = 75;
     full = true;
    };
  };

  programs.mpv.enable = true;
  
  #home.sessionVariables = {
  #  XDG_DATA_DIRS = "/home/frosk/.dotfiles/other/.desktop:${config.environment.variables.XDG_DATA_DIRS or ""}";
  #};

  hyprland = {
    enable = true;
  };

  yt-dlp.enable = true;

  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/frosk/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

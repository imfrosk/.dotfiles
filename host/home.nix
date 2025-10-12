{ config, pkgs, ... }:
{
  imports =
    [
      #./../modules/core/home.nix
      #./../modules/gui/home.nix
    ];
  home.username = "frosk";
  home.homeDirectory = "/home/frosk";
  home.stateVersion = "25.05"; # Please read the comment before changing.

  #nixpkgs.config.allowUnfree = true; 

  xdg.desktopEntries = {
    OBS = {
      name = "OBS";
      genericName = "with replay buffer";
      exec = "obs --startreplaybuffer";
      terminal = false;
      categories = [ "Application" ];
    };
  };

  programs = { 
    mpv.enable = true;
    vscode.enable = true;

    mangohud = {
      enable = true;
      settings = {
        fps_limit = 75;
        preset = 4;
      };
    };

    bash = {
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
        "..." = "cd ./../../";
        la = "ls -la";
        fr = "sudo nixos-rebuild switch --flake ~/.dotfiles";
        cdh = "cd ~/.dotfiles/host/";
        hyprm = "vi ~/.dotfiles/modules/gui/ux/hyprland/config/hyprland.conf";
        hyprd = "cd ~/.dotfiles/modules/gui/ux/hyprland/";

        cg = "cd ~/.dotfiles/modules/gui";
        cga = "cd ~/.dotfiles/modules/gui/apps";
        cgu = "cd ~/.dotfiles/modules/gui/ux/";
        cc = "cd ~/.dotfiles/modules/core";
        cch = "cd ~/.dotfiles/modules/core/hardware/";
        ccp = "cd ~/.dotfiles/modules/core/programs/";
        ccs = "cd ~/.dotfiles/modules/core/services/";

        lg = "lazygit -p ~/.dotfiles";
        sr = "sudo systemctl restart sing-box.service";
      };
    };
  };
}

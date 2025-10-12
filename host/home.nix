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
        la = "ls -la";
        fr = "sudo nixos-rebuild switch --flake ~/.dotfiles";
        hms = "home-manager switch --flake ~/.dotfiles";
        cdh = "cd ~/.dotfiles/host/";
        hyprm = "vi ~/.dotfiles/programs/home/hyprland/config/hyprland.conf";
        hyprd = "cd ~/.dotfiles/programs/home/hyprland/";
        cg = "cd ~/.dotfiles/modules/gui";
        cc = "cd ~/.dotfiles/modules/core";
        lg = "lazygit -p ~/.dotfiles";
        zp = "bash ~/.clone/zapret-discord-youtube-linux/main_script.sh";
        hmsmime = "rm ~/.config/mimeapps.list.backup && home-manager switch --flake ~/.dotfiles -b backup";
        sr = "sudo systemctl restart sing-box.service";
        sy = "sudo systemctl";
        syre = "sudo systemctl restart";
        sys = "sudo systemctl status";
      };
    };
  };
}

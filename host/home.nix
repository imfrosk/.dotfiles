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
    r2mod = {
      name = "r2mod";
      genericName = "Appimage";
      exec = "appimage-run /home/frosk/.dotfiles/other/appimage/r2modman.AppImage";
      terminal = false;
      categories = [ "Application" ];
    };
  };

  services.easyeffects.enable = true;

  programs = { 
    mpv.enable = true;
    vscode.enable = true;
    opencode.enable = false;

    mangohud = {
      enable = true;
      settings = {
        fps_limit = 75;
        preset = 4;
      };
    };

    bash = {
      enable = true;
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

        srn = "sudo systemctl restart navidrome.service";

        dssr = "dualsensectl speaker headphone && dualsensectl volume 255";

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

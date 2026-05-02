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

  #services.easyeffects.enable = true;

  programs = { 
    mpv = { 
      enable = true;
      config = {
        profile = "gpu-hq";
        vo = "gpu-next";
        hwdec = "auto";
        ytdl-format = "bestvideo+bestaudio";
        target-colorspace-hint = true;

        # interpolation
        video-sync = "display-resample"; 
        interpolation = true;

      };
      profiles = {
        "HDR_MODE:DOVI" = {
          profile-restore = "copy";
          target-trc = "pq";
          target-prim = "bt.2020";
          #Adjust this to the peak brightness of your display. e.g. 800 for LG CX
          target-peak = "1000"; 
          tone-mapping-mode = "auto";
          tone-mapping = "bt.2446a";
        };
        "HDR_MODE:SDR" = {
          profile-restore = "copy";
          gpu-api = "vulkan";
          target-trc = "pq";
          target-prim = "bt.2020";
          #Seems to be some kind of magic number, higher values do not have any effect 
          target-peak= "207";
          tone-mapping= "bt.2390";
          tone-mapping-mode = "rgb";
          inverse-tone-mapping = true;
        };
        "HDR_MODE:SDR_HDR_EFFECT" = {
          profile-restore = "copy";
          target-trc = "pq";
          target-prim = "bt.2020";
          # Higher value = stronger effect
          target-peak = "406";
          tone-mapping = "spline";
          # All other values make the colors look awful in my opinion. 
          tone-mapping-mode = "rgb";
          inverse-tone-mapping = true; 
        };
      };
      bindings = {
        "Alt+k" = "apply-profile HDR_MODE:DOVI";
        "CTRL+Shift+1" = "apply-profile HDR_MODE:DOVI restore";

        "CTRL+2" = "apply-profile HDR_MODE:SDR";
        "CTRL+Shift+2" = "apply-profile HDR_MODE:SDR restore";

        "CTRL+3" = "apply-profile HDR_MODE:SDR_HDR_EFFECT";
        "CTRL+Shift+3" = "apply-profile HDR_MODE:SDR_HDR_EFFECT restore";

        "CTRL+WHEEL_UP" = "add target-peak 1";
        "CTRL+WHEEL_DOWN" = "add target-peak -1";
      };
    };
    vscode.enable = true;
    opencode.enable = false;

    #mangohud = {
    #  enable = true;
    #  settings = {
    #    preset = 4;
    #  };
    #};

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

        dss = "dualsensectl volume 255";

        cg = "cd ~/.dotfiles/modules/gui";
        cga = "cd ~/.dotfiles/modules/gui/apps";
        cgu = "cd ~/.dotfiles/modules/gui/ux/";
        cgg = "cd ~/.dotfiles/modules/gui/gaming/";
        cc = "cd ~/.dotfiles/modules/core";
        cch = "cd ~/.dotfiles/modules/core/hardware/";
        ccp = "cd ~/.dotfiles/modules/core/programs/";
        ccs = "cd ~/.dotfiles/modules/core/services/";

        fwl = "";

        lg = "lazygit -p ~/.dotfiles";
        sr = "sudo systemctl restart sing-box.service";
      };
    };
  };
}

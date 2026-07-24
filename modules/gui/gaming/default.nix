{ config, lib, pkgs, inputs, myUser, ... }:
let
  cfg = config.gui.gaming;
in
{
  imports = [
      #./decky-loader.nix

     # (
     #   # Put the most recent revision here:
     #   let revision = "8ffb6db"; in
     #   builtins.fetchTarball {
     #     url = "https://github.com/Jovian-Experiments/Jovian-NixOS/archive/${revision}.tar.gz";
     #     # Update the hash as needed:
     #     sha256 = "sha256:13rc7jw5r7h1hqx51rls42w6p5bcn1dx8cqkmfahm2h9bx9zr4ip";
     #   } + "/modules"
     # )
    ];
  options.gui.gaming = {
    enable = lib.mkEnableOption "Enables steam, gamescope and gamemode";
    #gamescope-session.enable = lib.mkEnableOption "Enables gamescope-session";
    #decky-loader.enable = lib.mkEnableOption "Enables decky loader";
  };
  config = lib.mkIf cfg.enable {
    programs= {
      steam = {
        enable = true;
        gamescopeSession = {
          enable = true;
          env = {
            #WLR_RENDERER = "vulkan";
            DXVK_HDR = "1";
            ENABLE_GAMESCOPE_WSI = "1";
            STEAM_GAMESCOPE_VRR_SUPPORTED= "1";
            STEAM_MULTIPLE_XWAYLANDS = "1";
            LD_PRELOAD = "";
            PROTON_MMDEV_FAKE_EXCLUSIVE = "1";
            #WINE_FULLSCREEN_FSR = "1";
            # Games allegedly prefer X11
            #SDL_VIDEODRIVER = "x11";
          };
          args = [
            "--xwayland-count 2"
            #"--expose-wayland"
            #"--backend wayland"
            "--steam"
         
            "--adaptive-sync"
            "--hdr-enabled"
            "--hdr-itm-enable"
        
            #"--mangoapp"
        
           # External monitor
            "--prefer-output DP-2"
            "--output-width 2560"
            "--output-height 1440"
            "--nested-refresh 200.0"
          ];
          steamArgs = [
            "-tenfoot"
            "-pipewire-dmabuf"
            #"-steamdeck"
            #"-steamos3"
          ];
        };
        extraCompatPackages = with pkgs; [ proton-ge-bin ];
      };
      gamemode = {
        enable = true;
        settings = {
          general = {
            renice = 10;
          };
          cpu = {
            park_cores = "no";
            pin_cores = "yes";
          };
        };
      };
      gamescope = {
        enable = true;
        capSysNice = true;
       # args = [
       #     #"--xwayland-count 2"
       #     #"--expose-wayland"
       #     #"--backend wayland"
       #     #"--steam"
       #     #"--adaptive-sync"
       #     "--nested-width 2560"
       #     "--nested-height 1440"
       #     #"--fullscreen"
       #     "--nested-refresh 200.0"
       #     #"--framerate-limit 200.0"
       # ];
      };
    };

    systemd.services."getty@tty3" = {
      overrideStrategy = "asDropin";
      serviceConfig.ExecStart = ["" "@${pkgs.util-linux}/sbin/agetty agetty --login-program ${config.services.getty.loginProgram} --autologin frosk --noclear %I $TERM"];
    };

    environment.systemPackages = with pkgs; [
      gamescope
      gamescope-wsi
      #lsfg-vk

     # (pkgs.writeShellScriptBin "gamescope-session" ''
     #   sleep 10 &&
     #   WLR_RENDERER = "vulkan" DXVK_HDR = "1" ENABLE_GAMESCOPE_WSI = "1" STEAM_GAMESCOPE_VRR_SUPPORTED= "1" LD_PRELOAD = "" gamescope 
     #       --xwayland-count 2 
     #       --expose-wayland 
     #       --backend wayland 
     #       -e 

     #       --adaptive-sync 
     #       --hdr-enabled 
     #       --hdr-itm-enable 

     #       --mangoapp 
     #       --prefer-output DP-2 
     #       --output-width 2560 
     #       --output-height 1440 
     #       -r 200.0 
     #       -- 

     #       steam 
     #       -tenfoot 
     #       -pipewire-dmabuf 
     #       -steamdeck 
     #       -steamos3 
     # '')

     # (pkgs.writeShellScriptBin "gamescope-session" ''
     #   #!/usr/bin/env bash
     # 
     #   # Switch to TTY 3
     #     chvt 3;

     #     # Check if gamescope-wl is running
     #     if ! pgrep -x "gamescope-wl" > /dev/null; then
     #         # Start session and WAIT for it to finish
     #         gamescope-session-start;
     #         
     #         # Once gamescope-session-start exits, move back to TTY 2
     #         chvt 2;
     #         exit
     #     else
     #         # If already running, just go back to TTY 2 and exit
     #         chvt 2;
     #         exit 0
     #     fi
     # '')
     # (pkgs.writeShellScriptBin "gamescope-session-start" ''
     #   #!/usr/bin/env bash
     # 
     #  dss & steam-gamescope; chvt 2; exit
     # '')
     # (pkgs.writeShellScriptBin "gamescope-session-only" ''
     #   #!/usr/bin/env bash
     # 
     #   # Switch to TTY 3
     #       gnome-session-quit --logout --no-prompt;
     #       chvt 3;

     #       # Check if gamescope-wl is running
     #       if ! pgrep -x "gamescope-wl" > /dev/null; then
     #           # Start session and WAIT for it to finish
     #           gamescope-session-start;
     #           
     #           # Once gamescope-session-start exits, move back to TTY 2
     #           chvt 2;
     #           exit
     #       else
     #           # If already running, just go back to TTY 2 and exit
     #           chvt 2;
     #           exit 0
     #       fi
     # '')

     # (pkgs.writeShellScriptBin "steamos-select-branch" ''
     #   #!/usr/bin/env bash
     # 
     #   echo "Not applicable for this OS"
     # '')

     # (pkgs.writeShellScriptBin "steamos-update" ''
     #   #!/usr/bin/env bash
     # 
     #   exit 7;
     # '')

     # (pkgs.writeShellScriptBin "jupiter-biosupdate" ''
     #   #!/usr/bin/env bash
     # 
     #   exit 0;
     # '')
    ];

   # jovian = {
   #   decky-loader = {
   #     enable = true;
   #   };
   #   steam = {
   #     enable = false;
   #     #autoStart = false;
   #     #user = "frosk";
   #     #desktopSession = "gnome";
   #   };
   # };
   home-manager.users = {
     ${myUser} = { config, ... }: {
       programs.mangohud = {
         enable = true;
       };
       programs.bash = {
         profileExtra = ''
           if [[ $(tty) == "/dev/tty3" ]]; then
             steam-gamescope; chvt 2; exit
           fi
         '';
       };
       home.file = {
         ".config/gamescope/scripts/steamos-select-branch" = {
           executable = true;
           text = ''
             #!/usr/bin/env bash

             echo "Not applicable for this OS"
           '';
         };
         ".config/gamescope/scripts/steamos-update" = {
           executable = true;
           text = ''
             #!/usr/bin/env bash

             exit 7;
           '';
         };
         ".config/gamescope/scripts/jupiter-biosupdate" = {
           executable = true;
           text = ''
             #!/usr/bin/env bash

             exit 0;
           '';
         };
         ".config/gamescope/scripts/steamos-session-select" = {
           executable = true;
           text = ''
             #!/usr/bin/env bash

             steam -shutdown
           '';
         };
       };
     };
   };
  };
  
}

# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, pkgs-25-11, inputs, lib, myUser, ... }:
{

  imports =
    [
      ./hardware-configuration.nix
      ./../modules/import.nix
    ];
  nix = {
    optimise = {
      automatic = true;
      dates = "weekly";
    };
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = false;
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-then 7d";
    };
  };
  nixpkgs.config = { 
    allowUnfree = true;
    rocmSupport = true;
  };

  #nixpkgs.overlays = [
  #  (final: prev: {
  #    komelia = final.callPackage ../other/pkgs/komelia.nix { };
  #  })
  #];

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark.yaml";
    polarity = "dark";
    targets.qt = {
      platform = lib.mkForce "qtct";
    };
  };


  ##         ##
  ## Modules ##
  ##         ##


  core = {
    hardware = {
      gpu = {
        amd.enable = true;
      };
      audio = {
        pipewire.enable = true;
        pulseaudio.enable = false;
      };
    };
    programs = {
      git = {
        enable = true;
        userName = "frosk";
      };
      yt-dlp.enable = true;
    };
    services = {
      navidrome = {
        enable = false;
      };
      sunshine.enable = false;
      zapret.enable = false;
      sing-box = {
        enable = false;
        configDir = "${config.users.users.${myUser}.home}/.xf/.secrets/sing-box/configs";
        workingDir = "${config.users.users.${myUser}.home}/.xf/.secrets/sing-box/";
        user = "frosk";
        group = "users";
      };
    };
  };
  gui = {
    apps = {
      nemo.enable = true;
      #zen-browser.enable = false;
    };
    ux = {
      quickshell.enable = false;
      gnome.enable = true;
      hyprland = {
        enable = false;
        uwsm = false;
      };
    }; 
  };


  ##               ##
  ## System config ##
  ##               ##


  # Boot
  boot = { 
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [ "ntfs" ];
    loader = {
      efi = {
        canTouchEfiVariables = true;
      };
      grub = {
         enable = true;
         efiSupport = true;
         device = "nodev";
         useOSProber = true;
         configurationLimit = 15;
      };
    };
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      1337
      8080
    ];
    allowedUDPPorts = [
      1337
      8080
    ];
  };

  # automount ntfs hdd
  fileSystems = {
    "/mnt/hdd" = {
      device = "/dev/disk/by-uuid/0f277c71-752a-4cc1-a13b-4e5007aeeabf";
      fsType = "ext4";
      options = ["noatime" "rw" "users" "nofail"];
      noCheck = true;
    };
  };
  
  systemd.tmpfiles.rules = [
    "d /mnt/hdd 0755 frosk users - -"
  ];

  # swap
  swapDevices = [{
    device = "/dev/disk/by-uuid/f8ec64dd-f4a1-45bb-9056-6a5f52c26ffd";
  }];

  # Time zone.
  time.timeZone = "Europe/Moscow";

  # Language
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [ "en_US.UTF-8/UTF-8" "ru_RU.UTF-8/UTF-8" ];
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  networking = {
    hostName = "ash";
    networkmanager.enable = true;
    nftables.enable = true;
  };


  ##             ##
  ## User config ##
  ##             ##
  
  
  users.users.${myUser} = {
    isNormalUser = true;
    extraGroups = [ "adbusers" "networkmanager" "wheel" "video" "audio" "input" "gamemode" "docker" ];
  };

  hardware = {
    opentabletdriver.enable = true;
    bluetooth.enable = true;
  };
  
  programs = {
    lazygit.enable = true;
    appimage.enable = true;
    #waybar.enable = true;
    #nix-ld.enable = true;
    localsend.enable = true;

    # Cannot enable this and gnome at the same time
    
    #ssh = {
    #  startAgent = true;
    #  extraConfig = " 
    #    Host github.com
    #    IdentityFile ~/.ssh/nixdot
    #  ";
    #};
  };

  services = {
    envfs.enable = true;
    gvfs.enable = true;
    udisks2.enable = true;
    komga = {
      enable = false;
      settings = {
        server.port = 8090;
      };
    };
    kavita = {
      enable = false;
      tokenKeyFile = "/home/frosk/.temp-secrets/kavita-token";
    };
  };

  #virtualisation.waydroid.enable = true;

  security.polkit.enable = true;

  # Packages
  # $ nix search wget
  environment.systemPackages = 
    with pkgs; [

    # Music
    feishin
    lrcget
    #puddletag
    #picard
    #deadbeef
    flac

    # GUI Apps
    kitty
    brave
    keepassxc
    legcord
    telegram-desktop
    obs-studio
    orca-slicer
    blender
    #modrinth-app
    #r2modman
    obsidian
    kdePackages.kate
    #lutris
    #krita
    qimgv
    gimp
    qbittorrent
    #aseprite
    peazip
    putty
    anki-bin
    ankiAddons.anki-connect
    gparted
    pavucontrol
    #rofi
    filezilla
    #protonup-qt
    #ludusavi
    #lutris-unwrapped
    koreader
    #popsicle


    # TUI
    btop-rocm
    vim
    bluetui
    greetd
    inputs.nixcats.packages.${stdenv.hostPlatform.system}.nixCats

    # CLI
    unrar
    unzip
    p7zip
    dualsensectl
    #gnirehtet
    tree
    git
    fastfetch
    wget
    wakeonlan
    inputs.swww.packages.${pkgs.stdenv.hostPlatform.system}.swww

    # CLI animations
    cmatrix
    asciiquarium
    pipes
    ttysvr
    sl

    # Screenshots & OCR
    #grim
    #swappy
    #slurp
    #wl-clipboard-rs
    #tesseract

    # Dependencies
    ntfs3g
    btrfs-progs
    jq
    openssl
    libinput
    jdk
    exfatprogs
    #inputs.nixpkgs-25-11.legacyPackages.${pkgs.system}.alsa-lib
    #inputs.nixpkgs-25-11.legacyPackages.${pkgs.system}.alsa-ucm-conf
    
    #bluez

    # WinBoat
    #inputs.winboat.packages.${system}.winboat
    #freerdp
    #docker-compose
  ];

  #nixpkgs.overlays = [
  #  # Overlay: Use `self` and `super` to express
  #  # the inheritance relationship
  #  (self: super: {
  #    alsa-lib = pkgs-25-11.alsa-lib;
  #    alsa-ucm-conf = pkgs-25-11.alsa-ucm-conf;
  #    bluez = pkgs-25-11.bluez;
  #    libsndfile = pkgs-25-11.libsndfile;
  #    libpulseaudio = pkgs-25-11.libpulseaudio;
  #    libao = pkgs-25-11.libao;
  #  })
  #];

  #virtualisation.docker.enable = true;

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    liberation_ttf
    nerd-fonts.ubuntu
    roboto-mono
    font-awesome
  ];


 

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.

  system.stateVersion = "25.05";
}

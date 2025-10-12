# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, lib, myUser, ... }:
#let
#  myUser = "frosk";
#in
{

  imports =
    [
      ./hardware-configuration.nix
      ./../modules/import.nix
    ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;


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
      git.enable = true;
      yt-dlp.enable = true;
    };
    services = {
      navidrome.enable = true;
      sunshine.enable = false;
      zapret.enable = false;
      sing-box = {
        enable = true;
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
      wm = {
        hyprland = {
          enable = true;
          uwsm = true;
        };
      };
      quickshell.enable = false;
    };
  };


  ##               ##
  ## System config ##
  ##               ##


  # Bootloader.
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

  # automount ntfs hdd
  fileSystems."/mnt/hdd" =
    { device = "/dev/disk/by-uuid/652140FF608D5959";
      fsType = "ntfs";
      options = [ "rw" "uid=1000" "gid=100" "umask=022" "nofail" ];
      #noCheck = false;
    };

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
    firewall.enable = false;
  };


  ##             ##
  ## User config ##
  ##             ##
  
  
  users.users.${myUser} = {
    isNormalUser = true;
    extraGroups = [ "adbusers" "networkmanager" "wheel" "video" "audio" "input" "gamemode" ];
  };

  hardware = {
    opentabletdriver.enable = true;
  };
  
  programs = {
    lazygit.enable = true;
    appimage.enable = true;
    waybar.enable = true;
    nix-ld.enable = true;
    ssh = {
      startAgent = true;
      extraConfig = " 
        Host github.com
        IdentityFile ~/.ssh/nixdot
      ";
    };
  };

  services = {
    gvfs.enable = true;
    udisks2.enable = true;
  };

  security.polkit.enable = true;

  # Packages
  # $ nix search wget
  environment.systemPackages = with pkgs; [

    # Music
    feishin
    lrcget
    puddletag
    picard
    deadbeef
    flac

    # GUI Apps
    kitty
    brave
    keepassxc
    vesktop
    telegram-desktop
    obs-studio
    orca-slicer
    blender-hip
    modrinth-app
    obsidian
    lutris
    krita
    qimgv
    gimp
    qbittorrent
    aseprite
    peazip
    putty
    anki-bin
    ankiAddons.anki-connect
    gparted
    pavucontrol
    rofi

    # TUI
    btop-rocm
    vim
    inputs.nixcats.packages.${system}.nixCats

    # CLI
    unrar
    unzip
    p7zip
    gnirehtet
    tree
    git
    neofetch
    wget
    inputs.swww.packages.${pkgs.system}.swww

    # Screenshots & OCR
    grim
    swappy
    slurp
    wl-clipboard-rs
    tesseract

    # Dependencies
    ntfs3g
    jdk24
    jq
    openssl
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
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

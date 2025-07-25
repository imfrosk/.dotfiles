# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  # Baza
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./nvidia.nix
      ./../../programs/system/default.nix
      ./../../programs/home/default.nix
    ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # Bootloader.
  boot = { 
    kernelPackages = pkgs.linuxPackages_latest;
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

  swapDevices = [{
    device = "/swapfile";
    size = 16 * 1024; # 16GB
  }];

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
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
  
    # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.frosk = {
    isNormalUser = true;
    description = "frosk";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "input" "gamemode" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    nano vim git neofetch wget kitty firefox
    rofi-wayland
    vesktop keepassxc
    obsidian
    pavucontrol
    godot_4_4
    blender
    orca-slicer
    inputs.nixcats.packages.${system}.nixCats
    inputs.swww.packages.${pkgs.system}.swww
    qbittorrent
    qimgv
    ntfs3g
    font-awesome
    lutris
    p7zip
    unzip
    openssl
    putty
    hyprshot
    jq
    gimp
    inputs.quickshell.packages.${system}.default
  ];

  programs.lazygit.enable = true;

  programs.appimage.enable = true;

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    nerd-fonts.ubuntu
    roboto-mono
    font-awesome
  ];

  programs.file-roller.enable = true;

  programs.waybar.enable = true;

  programs.nix-ld.enable = true;

  programs.ssh.extraConfig = " 
    # Test if github.com works with ssh for cloning
    Host github.com
    IdentityFile ~/.ssh/nixdot
  ";

  programs.ssh.startAgent = true;

  hyprland = {
    enable = true;
    uwsm = true;
  };
    # rtkit (optional, recommended) allows Pipewire to use the realtime scheduler for increased performance.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true; # if not already enabled
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment the following
    #jack.enable = true;
  };

  services.gvfs.enable = true;
  services.udisks2.enable = true;

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

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}

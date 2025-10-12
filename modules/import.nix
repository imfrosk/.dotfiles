{ pkgs, lib, ... }:

{
  imports = [
    ./core/hardware/gpu/nvidia.nix
    ./core/hardware/gpu/amd.nix
    ./core/hardware/audio/pipewire.nix
    ./core/hardware/audio/pulseaudio.nix

    ./core/programs/git.nix
    ./core/programs/yt-dlp.nix

    ./core/services/navidrome.nix
    ./core/services/sunshine.nix
    ./core/services/zapret/zapret.nix
    ./core/services/sing-box.nix


    ./gui/apps/nemo.nix
    #./gui/apps/zen-browser.nix

    ./gui/ux/wm/hyprland/hypr.nix
    ./gui/ux/quickshell/quickshell.nix

    ./gui/gaming/default.nix
    ./gui/.themes/home.nix
  ];
}

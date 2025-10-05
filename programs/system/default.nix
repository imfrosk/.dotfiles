{ pkgs, lib, ... }:

{
  imports = [
    ./zapret/default.nix
    ./sing-box/default.nix
    ./audio/pipewire.nix
    ./audio/pulseaudio.nix
  ];
}

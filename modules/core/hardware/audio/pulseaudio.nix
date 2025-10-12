{ config, pkgs, lib, ...}:
let
  cfg = config.core.hardware.audio.pulseaudio;
in
{
  options.core.hardware.audio.pulseaudio = {
    enable = lib.mkEnableOption "Enable pulseaudio audio";
  };

  config = lib.mkIf cfg.enable {
    services.pipewire.enable = lib.mkForce false;
    services.pulseaudio = { 
      enable = lib.mkForce true;
      support32Bit = true;
    };
    nixpkgs.config.pulseaudio = true;
    hardware.alsa = {
      enable = true;
    };
  };
}

{ config, pkgs, lib, ... }:
let
  cfg = config.driver.pipewire;
in
{
  options.driver.pipewire = {
    enable = lib.mkEnableOption "Enables pipewire audio";
  };

  config = lib.mkIf cfg.enable {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true; # if not already enabled
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
      extraConfig.pipewire = {
        "context.properties" = {
          "default.clock.quantum" = 64;  # Reduce from default 1024
          "default.clock.min-quantum" = 32;
          "default.clock.max-quantum" = 1024;
        };
      };
    };
  };
}

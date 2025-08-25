{ lib, config, ... }:

{
  options.navidrome = {
    enable = lib.mkEnableOption "enables Navidrome";
  };

  config = lib.mkIf config.navidrome.enable {
    services.navidrome = {
      enable = true;
      settings = {
        MusicFolder = "/mnt/hdd/music";
        Address = "0.0.0.0";
      };
    };
  };
}

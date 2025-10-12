{ lib, config, ... }:
let
  cfg = config.core.services.navidrome;
in
{
  options.core.services.navidrome = {
    enable = lib.mkEnableOption "enables Navidrome";
  };

  config = lib.mkIf cfg.enable {
    services.navidrome = {
      enable = true;
      settings = {
        MusicFolder = "/mnt/hdd/music";
        #DataFolder = "/home/frosk/.xf/.pst/navidrome";
        Address = "0.0.0.0";

        #Backup.Path = "/home/frosk/.xf/backups/Programs/navidrome";
        #Backup.Count = "6";
        #Backup.Schedule = "0 0 * * *";
      };
    };
  };
}

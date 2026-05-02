{ lib, config, pkgs, ... }:
let
  cfg = config.core.services.navidrome;
in
{
  options.core.services.navidrome = {
    enable = lib.mkEnableOption "enables Navidrome";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.navidrome ];
    services.navidrome = {
      enable = true;
      openFirewall = true;
      settings = {
        MusicFolder = "/mnt/hhd/.xfs/music";
        Address = "127.0.0.1";

        #Backup.Path = "/home/frosk/.xf/backups/Programs/navidrome";
        #Backup.Count = "6";
        #Backup.Schedule = "0 0 * * *";
      };
    };
    security.sudo = {
      enable = true;
      extraRules = [{
        groups = [ "wheel" ];
        commands = [
          {
            command = "/run/current-system/sw/bin/systemctl restart navidrome.service";
            options = [ "NOPASSWD" ];
          }
        ];
      }];
    };
  };
}

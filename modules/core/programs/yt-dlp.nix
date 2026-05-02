{ pkgs, lib, config, ... }: 
let
  cfg = config.core.programs.yt-dlp;
in
{

  options.core.programs.yt-dlp = {
    enable = lib.mkEnableOption "Enables yt-dlp";
  };

  config = lib.mkIf cfg.enable {
    home-manager.sharedModules = [ {
      programs.yt-dlp = {
        enable = true;
        settings = {
          embed-thumbnail = true;
          embed-subs = true;
          embed-metadata = true;
          embed-chapters = true;
          sponsorblock-mark = "sponsor,selfpromo,preview,filler";
          downloader = "aria2c";
          downloader-args = "aria2c:'-c -x8 -s8 -k1M'";
          audio-quality = "0";
          write-description = true;
          format = "bestvideo*+bestaudio/best";
          force-ipv4 = true;
          sub-langs = "en.*,ru.*";
          yes-playlist = true;
          paths = "/mnt/hdd/Downloads/yt-dlp/";
        };
      };
    } ];
  };
}

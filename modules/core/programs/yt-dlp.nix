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
          sub-langs = "en.*,ru.*";
          paths = "~/Downloads/yt-dlp";
        };
        extraConfig = 
        ''
        -f "bv+ba/b"
        '';
      };
    } ];
  };
}

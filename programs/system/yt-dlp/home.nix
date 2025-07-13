{ pkgs, lib, config, ... }: {

  options = {
    yt-dlp.enable = 
      lib.mkEnableOption "enables yt-dlp";
  };

  config = lib.mkIf config.yt-dlp.enable {
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
  };
}

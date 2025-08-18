{ pkgs, lib, config, ...}:

{
  options.sunshine = {
    enable = lib.mkEnableOption "Enables sunshine";
  };

  config = lib.mkIf config.sunshine.enable {
    services.sunshine = {
      enable = true;
      package = pkgs.sunshine.override { cudaSupport = true; };
      capSysAdmin = true;
      openFirewall = true;
      settings = {
        sunshine_name = "nixos";
        output_name = "1";
        #capture = "wlr";
        #encoder = "software";
        adapter_name = "/dev/dri/renderD128";
      };
      applications = {
        env = {
          PATH = "$(PATH):$(HOME)/.local/bin";
        };
        apps = [
          {
            name = "Second screen";
            prep-cmd = [
              {
                do = "hyprctl output create headless PM-HEADLESS";
                undo = "hyprctl output remove PM-HEADLESS";
              }
            ];
            exclude-global-prep-cmd = "false";
            auto-detach = "true";
          }
        ];
      };
      
    };
  };
}

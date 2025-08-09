{ pkgs, lib, config, ...}:

{
  options.sunshine = {
    enable = lib.mkEnableOption "Enables sunshine";
  };

  config = lib.mkIf config.sunshine.enable {
    services.sunshine = {
      enable = true;
      capSysAdmin = true;
      settings = {
        sunshine_name = "nixos";
      };
    };
  };
}

{ config, lib, ... }:

{
  options.sing-box = {
    enable = lib.mkEnableOption "Enables sing-box";
  };
  config = lib.mkIf config.sing-box.enable {
    services.sing-box.enable = true;
  };
}

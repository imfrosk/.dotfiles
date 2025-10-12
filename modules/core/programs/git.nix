{ config, lib, myUser, ... }:
let
  cfg = config.core.programs.git;
in
{
  options.core.programs.git = { 
    enable = lib.mkEnableOption "enables module1";
    userName = lib.mkOption {
      type = lib.types.str;
      default = "${myUser}";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.sharedModules = [ {
      programs.git = {
        enable = true;
        userName = cfg.userName;
        userEmail = "ash@mail";
        extraConfig = {
          init.defaultBranch = "main";
        };
      };
    } ];
  };
}

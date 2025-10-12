{ inputs, config, pkgs, lib, myUser, ... }:
with lib;
let
  cfg = config.gui.ux.quickshell;
in
{
  options.gui.ux.quickshell = {
    enable = lib.mkEnableOption "enables quickshell";
  };
  
  config = lib.mkIf cfg.enable {
    home-manager.users.${myUser} = { config, ... }: {
      config = mkIf cfg.enable {
        home = {
          file.".config/quickshell" = {
            source = config.lib.file.mkOutOfStoreSymlink
              "${config.home.homeDirectory}/.dotfiles/modules/gui/ux/quickshell";
            recursive = true;
          };
          packages = with pkgs; [
            inputs.quickshell.packages.${system}.default
          ];
        };
      };
    };
  };
}

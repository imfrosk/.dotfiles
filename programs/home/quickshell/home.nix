{ inputs, config, pkgs, lib, ... }:
with lib;
let
  cfg = config.quickshell;
in
{
  options.quickshell = {
    enable = lib.mkEnableOption "enables quickshell";
  };
  
  config = mkIf cfg.enable {
    home = {
      file.".config/quickshell" = {
        source = config.lib.file.mkOutOfStoreSymlink
          "${config.home.homeDirectory}/.dotfiles/programs/home/quickshell";
        recursive = true;
      };
      packages = with pkgs; [
        inputs.quickshell.packages.${system}.default
      ];
    };
  };
}

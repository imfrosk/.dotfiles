{ pkgs, ... }:

{
#  programs = {
#    thunar = {
#      enable = true;
#      plugins = with pkgs.xfce; [
#      thunar-archive-plugin
#      thunar-volman 
#      thunar-vcs-plugin
#      ];
#    };
#    file-roller.enable = true;
#  };
#  services = { 
#    gvfs.enable = true;
#    tumbler.enable = true;
#  };
  environment.systemPackages = [ pkgs.ffmpegthumbnailer ];
}

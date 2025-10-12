{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./decky-loader.nix
  ];
  
  # Steam

  nixpkgs.overlays = [
    (final: prev:
      {
        decky-loader = final.callPackage ./../../../other/pkgs/decky-loader { };
      }
    )
  ];
  
  programs= {
    steam = {
      enable = true;
      extraCompatPackages = with pkgs; [ proton-ge-bin ];
    };
    gamemode = {
      enable = true;
      settings = {
        general = {
          renice = 10;
        };
        cpu = {
          park_cores = "no";
          pin_cores = "yes";
        };
      };
    };
  };
  
  services.decky-loader= {
    enable = true;
  };
}

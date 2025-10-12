{ pkgs, config, lib, ...}:
let
  cfg = config.core.hardware.gpu.amd;
in
{
  options.core.hardware.gpu.amd = {
    enable = lib.mkEnableOption "Enables config for amd gpu";
  };
  config = lib.mkIf cfg.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        rocmPackages.clr.icd
        #rocmPackages.rocm-smi
        libva
        libva-utils
      ];
    };
  };
}

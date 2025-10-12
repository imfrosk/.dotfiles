{ pkgs, config, lib, ...}:
let
  cfg = config.core.hardware.gpu.nvidia;
in
{
  options.core.hardware.gpu.nvidia = {
    enable = lib.mkEnableOption "Enables drivers and config for nvidia gpu";
  };

  config = lib.mkIf cfg.enable {
    services.xserver.videoDrivers = ["nvidia"];

    environment.variables = {
      GBM_BACKEND = "nvidia-drm";
      LIBVA_DRIVER_NAME = "nvidia";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      VDPAU_DRIVER = "nvidia";
    };

    environment.systemPackages = with pkgs; [
      vulkan-loader
      vulkan-validation-layers
      vulkan-tools
    ];

    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
          nvidia-vaapi-driver
          libva-vdpau-driver
          libvdpau-va-gl
        ];
      };
      nvidia = {
        modesetting.enable = true;
        powerManagement.enable = false;
        powerManagement.finegrained = false;
        nvidiaSettings = true;
        open = false;
        videoAcceleration = true;
        package = config.boot.kernelPackages.nvidiaPackages.beta;
      };
    };
  };
}

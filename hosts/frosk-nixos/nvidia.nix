{config, ...}:
 {
  services.xserver.videoDrivers = ["nvidia"];
  hardware = {
   graphics.enable = true; # Enable OpenGl
   nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    nvidiaSettings = false;
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
   };
  };
 }

{ config, lib, pkgs, ... }:

let
  alsa-ucm-conf-dualsense-haptics =
    with pkgs;
    alsa-ucm-conf.overrideAttrs {

      # https://github.com/alsa-project/alsa-ucm-conf/issues/677#issuecomment-3755019801
      patches = [
        ./a.patch
      ];
      version = "1.2.15.3";
      src = fetchurl {
        url = "mirror://alsa/lib/alsa-ucm-conf-1.2.15.3.tar.bz2";
        hash = "sha256-n3noE8CPyGz6Rt11xPzaGkpRtILbJgfh/PqvuS9YijE=";
      };
    };
in
{
  environment.sessionVariables.ALSA_CONFIG_UCM2 = "${alsa-ucm-conf-dualsense-haptics}/share/alsa/ucm2";

  security.sudo.extraRules = [
    {
      users = [ "decky" ];
      runAs = "root";
      commands = [
        {
          command = "/run/current-system/sw/bin/dualsensectl volume 255";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
  services.udev.extraRules = ''
   #   # Match the input device by its name attribute directly
   # SUBSYSTEM=="input", ATTRS{name}=="*DualSense*Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
   # 
   # # Alternative if the above fails: use the Vendor and Product IDs
   # # 054c = Sony, 0ce6 = DualSense
   #SUBSYSTEM=="input", ATTRS{id/vendor}=="054c", ATTRS{id/product}=="0ce6", ENV{ID_INPUT_TOUCHPAD}=""
   ACTION=="add|change", KERNEL=="event[0-9]*", ATTRS{name}=="Sony Interactive Entertainment DualSense Wireless Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
   #ACTION=="add|change", KERNEL=="event[0-9]*", ATTRS{id/vendor}=="054c", ENV{LIBINPUT_IGNORE_DEVICE}="1"
  '';
  #boot.initrd.services.udev.rules = ''
  #  ACTION=="add|change", KERNEL=="event[0-9]*", ATTRS{product}=="Sony Interactive Entertainment DualSense Wireless Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
  #'';

  #boot.kernelModules = [ "hid-playstation" ];

  home-manager.users = { 
    decky = { config, ... }: {
      home.stateVersion = "25.05";
      programs.bash = {
        enable = true;
        shellAliases = {
          dss = "sudo dualsensectl volume 255";
        };
      };
    };
  };
}

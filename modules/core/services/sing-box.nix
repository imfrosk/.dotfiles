{ config, lib, pkgs, ... }:

let
  cfg = config.core.services.sing-box;
in

{
  options.core.services.sing-box = {
    enable = lib.mkEnableOption "Enables sing-box";
    package = lib.mkPackageOption pkgs "sing-box" { };
    user = lib.mkOption {
      type = lib.types.str;
      default = "sing-box";
      description = "User account under which sing-box runs";
    };
    group = lib.mkOption {
      type = lib.types.str;
      default = "sing-box";
      description = "Group account under which sing-box runs";
    };
    configDir = lib.mkOption {
      type = lib.types.path;
      default = "/etc/sing-box/config.json";
      description = "Path to main sing-box config directory";
    };
    workingDir = lib.mkOption {
      type = lib.types.path;
      default = "/etc/sing-box/wd";
      description = "Path to main sing-box working directory";
    };
  };
  config = lib.mkIf cfg.enable {
    services.sing-box.enable = false;
    environment.systemPackages = [ cfg.package ];
    services.dbus.packages = [ cfg.package ];
    #systemd.packages = [ cfg.package ];

    systemd.services.sing-box = {
      serviceConfig = {
        User = cfg.user;
        Group = cfg.group;
        #StateDirectory = "sing-box";
        #StateDirectoryMode = "0700";
        #RuntimeDirectory = "sing-box";
        #RuntimeDirectoryMode = "0700";
        ExecStart = "${lib.getExe cfg.package} run -C ${cfg.configDir} -D ${cfg.workingDir}";
        CapabilityBoundingSet = [ "CAP_NET_ADMIN" ];
        AmbientCapabilities = [ "CAP_NET_ADMIN" ];
      };
      wantedBy = [ "multi-user.target" ];
    };

    security.sudo = {
      enable = true;
      extraRules = [{
        groups = [ "wheel" ];
        commands = [
          {
            command = "/run/current-system/sw/bin/systemctl restart sing-box.service";
            options = [ "NOPASSWD" ];
          }
        ];
      }];
    };

    users.users.sing-box = {
      isSystemUser = true;
      group = "sing-box";
    };
    users.groups.sing-box = { };
  };
}

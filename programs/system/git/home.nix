{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "frosk";
    userEmail = "hz@mail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}

{ pkgs, ... }:

{
  programs.ags = {
    enable = true;
    extraPackages = with pkgs; [
      graphene
      gtk4
    ];
  };
}

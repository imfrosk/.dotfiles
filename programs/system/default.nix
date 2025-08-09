{ pkgs, lib, ... }:

{
  imports = [
    ./zapret/default.nix
    ./sing-box/default.nix
  ];
}

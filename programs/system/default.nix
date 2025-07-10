{ pkgs, lib, ... }:

{
  imports = [
    #./nix-alien/default.nix
    ./zapret/default.nix
  ];
}

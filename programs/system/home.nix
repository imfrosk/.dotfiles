{ pkgs, lib, ... }:

{
  imports = [
    ./git/home.nix
    ./yt-dlp/home.nix
  ];
}

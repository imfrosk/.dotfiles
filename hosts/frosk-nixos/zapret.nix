{ config, lib, pkgs, ... }:
 { 
  services.zapret = {
   enable = true;
   udpSupport = true;
   httpSupport = true;
   httpMode = "full";
   configureFirewall = true; 
   whitelist = [
   "cloudflare-ech.com
dis.gd
discord-attachments-uploads-prd.storage.googleapis.com
discord.app
discord.co
discord.com
discord.design
discord.dev
discord.gift
discord.gifts
discord.gg
discord.media
discord.new
discord.store
discord.status
discord-activities.com
discordactivities.com
discordapp.com
discordapp.net
discordcdn.com
discordmerch.com
discordpartygames.com
discordsays.com
discordsez.com
yt3.ggpht.com
yt4.ggpht.com
yt3.googleusercontent.com
googlevideo.com
jnn-pa.googleapis.com
stable.dl2.discordapp.net
wide-youtube.l.google.com
youtube-nocookie.com
youtube-ui.l.google.com
youtube.com
youtubeembeddedplayer.googleapis.com
youtubekids.com
youtubei.googleapis.com
youtu.be
yt-video-upload.l.google.com
ytimg.com
ytimg.l.google.com
frankerfacez.com
ffzap.com
betterttv.net
7tv.app
7tv.io"
   ];
   udpPorts = [ 
    "443"
    "50000:50100"
   ];
   params = [
    "--dpi-desync=multisplit --dpi-desync-split-pos=10,sniext+4 --dpi-desync-split-seqovl=1"
   ];
   
  };
  
  
 } 


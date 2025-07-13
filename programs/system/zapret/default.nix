{ config, lib, pkgs, ... }:
 { 
 imports = [
  ./lists/general-domains.nix 
  ./lists/discord-main-ip.nix
 ]; 
    services.zapret = {
      enable = true;
      udpSupport = true;
      httpSupport = true;
      httpMode = "full";
      configureFirewall = true; 
      udpPorts = [ 
       "443"
       "50000:50100"
      ];
      params = [
        "--filter-udp=50000-50100 --dpi-desync=fake --dpi-desync-any-protocol --dpi-desync-cutoff=d3 --dpi-desync-repeats=6"
        "--filter-udp=443 --dpi-desync=multisplit --dpi-desync-split-pos=10,sniext+4 --dpi-desync-split-seqovl=1"
        "--filter-tcp=443 --dpi-desync-fake-tls=0x00000000 --dpi-desync-fake-tls=! --dpi-desync-fake-tls-mod=rnd,rndsni,dupsid" 
     
      ];
   
  };
  
  
}

{

  description = "zaebis flake";

  inputs = {
   home-manager.url = "github:nix-community/home-manager/master"; 
   home-manager.inputs.nixpkgs.follows = "nixpkgs";
   nixpkgs.url = "nixpkgs/nixos-unstable";
   hyprland.url = "github:hyprwm/Hyprland";
   #nixcats.url = "github:BirdeeHub/nixCats-nvim";
   nixcats.url = "path:/home/frosk/.dotfiles/programs/system/nvim";
   nix-alien.url = "github:thiagokokada/nix-alien";
   ags.url = "github:Aylur/ags";
  };

  outputs = { self, nixpkgs, home-manager, hyprland, nix-alien, ... }@inputs: 
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs self system; };
        modules = [ 
        ./hosts/frosk-nixos/configuration.nix

        # nix-alien
        #({ self, system, ... }: {
        #    environment.systemPackages = with self.inputs.nix-alien.packages.${system}; [
        #      nix-alien
        #    ];
        #    programs.nix-ld.enable = true;
        #  })
        ];
      };
     };
    homeConfigurations = { 
      frosk = home-manager.lib.homeManagerConfiguration {
        inherit pkgs; 
        modules = [ 
        ./hosts/frosk-nixos/home.nix
        inputs.ags.homeManagerModules.default
        ];
      };
    };
    #packages."x86_64-linux".default = 
    #  (nvf.lib.neovimConfiguration {
    #    inherit pkgs;
#	modules = [ ./programs/home/nvf/default.nix ];
#      }).neovim;
  };

}

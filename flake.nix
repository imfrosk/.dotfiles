{

  description = "zaebis flake";

  inputs = {
    home-manager.url = "github:nix-community/home-manager/master"; 
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs.url = "nixpkgs/nixos-unstable";

    #zen-browser = {
    #  url = "github:0xc000022070/zen-browser-flake";
    #  # IMPORTANT: needs to be nixos-unstable
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};

    hyprland.url = "github:hyprwm/Hyprland/v0.50.1";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    hypr-dynamic-cursors = {
       url = "github:VirtCode/hypr-dynamic-cursors";
       inputs.hyprland.follows = "hyprland";
    };

    quickshell = {
       url = "github:quickshell-mirror/quickshell";
       inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcats.url = "path:/home/frosk/.dotfiles/programs/system/nvim";
    swww.url = "github:LGFae/swww";
   };

  outputs = { self, nixpkgs, home-manager, hyprland, ... }@inputs: 
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
    in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs self system; };
        modules = [ 
        ./hosts/frosk-nixos/configuration.nix
        ];
      };
     };
    homeConfigurations = { 
      frosk = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = { inherit inputs; };
        modules = [ 
        ./hosts/frosk-nixos/home.nix
        ];
      };
    };
  };
}

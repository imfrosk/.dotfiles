{

  description = "main flake";

  inputs = {
    home-manager.url = "github:nix-community/home-manager/master"; 
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs.url = "nixpkgs/nixos-unstable";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      # IMPORTANT: needs to be nixos-unstable
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland/v0.51.0";
      #rev = "91f592a87509436dc6f6ea7b3d6705ed7c5af046";
    };
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
    winboat = {
      url = "github:TibixDev/winboat";
      # think needs to be unstable
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcats.url = "path:/home/frosk/.dotfiles/modules/core/programs/nvim";
    swww.url = "github:LGFae/swww";
   };

  outputs = { self, nixpkgs, home-manager, hyprland, ... }@inputs: 
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
    in 
    {
    nixosConfigurations = {
      ash = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs self system; 
        myUser = "frosk"; 
        };
        modules =
        [ 
          ./host/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              extraSpecialArgs = { inherit inputs; };
              useGlobalPkgs = true;
              useUserPackages = true;
              users.frosk = import ./host/home.nix;
              backupFileExtension = "backup";
            };
          }
        ];
      };
    };
    #homeConfigurations = { 
    #  frosk = home-manager.lib.homeManagerConfiguration {
    #    pkgs = nixpkgs.legacyPackages.${system};
    #    extraSpecialArgs = { inherit inputs; };
    #    modules = [ 
    #    ./host/home.nix
    #    ];
    #  };
    #};
    };
}

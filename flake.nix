{
  description = "nandv's nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, home-manager, flake-utils, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };

      mkHost = { hostname, username ? "nandv" }: 
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs hostname username;
          };
          modules = [
	    ({ lib, ... }: { warnings = [ "Loading configuration for ${hostname}" ]; })

            # Host-specific configuration
            ./hosts/${hostname}/configuration.nix
            ./hosts/${hostname}/hardware-configuration.nix

            # Home-manager module
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit inputs username;
              };
              home-manager.users.${username} = {
                imports = [ 
                  ./home/home.nix
                  ./home/packages.nix 
                ];
              };
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        nebula = mkHost {
          hostname = "nebula";
          username = "abyss";
        };
      };

      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          nil 
          nixpkgs-fmt
          statix
        ];
      };
    } // flake-utils.lib.eachDefaultSystem (system: {
      formatter = pkgs.nixpkgs-fmt;
    });
}

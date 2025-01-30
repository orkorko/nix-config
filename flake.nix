{
  description = "nandv's nixos config";
  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    ghostty.url = "github:ghostty-org/ghostty";
    themes.url = "github:RGBCube/ThemeNix";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs =
    { self, nixpkgs, home-manager, flake-utils, themes, nixvim, ... }@inputs:
    let
      inherit (self) outputs;
      values = import ./lib/values.nix nixpkgs.lib;
      lib =
        nixpkgs.lib.extend (self: super: home-manager.lib // values);
      mkHost = { hostname, username, system ? "x86_64-linux", extraModules ? [ ]
        , extraSpecialArgs ? { } }:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = [ inputs.emacs-overlay.overlays.default ];
          };
        in nixpkgs.lib.nixosSystem {
          inherit system;
          pkgs = pkgs;
          specialArgs = {
            inherit inputs hostname username lib;
          } // extraSpecialArgs;
          modules = [
            ({ lib, ... }: {
              warnings = [ "Loading configuration for ${hostname}" ];
            })
            ./modules/nixos
            ./hosts/${hostname}
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit inputs nixvim lib;
              } // extraSpecialArgs;
              home-manager.users.${username} = {
                imports = [ ./modules/home ./users/${username} ];
                home.homeDirectory = "/home/${username}";
                home.username = username;
              };
            }
          ] ++ extraModules;
        };
    in {
      inherit lib;
      nixosConfigurations = {
        fyr = mkHost {
          hostname = "fyr";
          username = "abyss";
          extraSpecialArgs = { inherit themes; };
        };
      };
    };
}

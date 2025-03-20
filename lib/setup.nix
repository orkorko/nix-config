{ self, nixpkgs, home-manager, nixvim, agenix, themes, ... }@inputs:
let
  lib' = import ./. inputs.nixpkgs.lib;
  lib = inputs.nixpkgs.lib.extend (self: super: inputs.home-manager.lib // lib');
  desktopOption = isDesktop:
    (_: { options.isDesktop = lib.mkValue isDesktop; });
in {
  mkHost = { 
    hostname,
    stateVersion, 
    username,
    isDesktop ? false,
    pkgs ? inputs.nixpkgs,
    system ? "x86_64-linux"
  }:
    with pkgs; lib.nixosSystem {
      specialArgs = {
        inherit self inputs outputs stateVersion username hostname lib system agenix;
      };
      pkgs = import nixpkgs {
          inherit system;
          hostPlatform = lib.mkDefault system;
          overlays = [ (import inputs.emacs-overlay) ];
          config.allowUnfree = true;
      };
      modules = [
        (desktopOption isDesktop)
        agenix.nixosModules.default
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {
            inherit self outputs stateVersion hostname username nixvim themes isDesktop;
          };
          home-manager.users.${username} = {
            imports = [
              (desktopOption isDesktop)
              ../options/theme.nix
              ../modules/home
            ];
          };
        }
        ../modules/system
        ../hosts/${hostname}
      ];
    };
}

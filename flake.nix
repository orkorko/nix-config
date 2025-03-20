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
    agenix.url = "github:ryantm/agenix";
  };
  outputs = { self, ... }@inputs:
    let
      inherit (self) outputs;
      setup = import ./lib/setup.nix inputs;
    in {
      nixosConfigurations = {
        yana = setup.mkHost {
          hostname = "yana";
          username = "eka";
          isDesktop = true;
          stateVersion = "23.05";
        };
      };
    };
}

{ config, pkgs, ... }:

{
    imports = [ 
        ./packages.nix
        ../modules/scripts/default.nix
        ../modules/zsh.nix
        ../modules/git.nix
        ../modules/tmux.nix
        ../modules/alacritty.nix
    ];

    programs.home-manager.enable = true;
    services.picom.enable = false;
    home.stateVersion = "24.05"; 
    home.username = "abyss";
    home.homeDirectory = "/home/abyss";

    home.file = {
        ".config/nvim".source = ../modules/dotfiles/nvim;
    };

    home.sessionVariables = {
        EDITOR = "nvim";
    };
}


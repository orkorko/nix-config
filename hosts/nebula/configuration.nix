{ config, pkgs, inputs, ... }:

{
    imports = [
        ./hardware-configuration.nix 
        ./packages.nix
        ../../cachix.nix
        ../../modules/grub.nix
        ../../modules/networking.nix
        ../../modules/x11.nix
        ../../modules/desktop.nix
        ../../modules/sound.nix
        ../../modules/locale.nix
        ../../modules/gnupg.nix
        ../../modules/steam.nix
        ../../modules/scripts/scrap/default.nix
        ../../modules/cron.nix
    ];

    system.stateVersion = "23.05";

    nix.settings = {
        experimental-features = [ "nix-command" "flakes" ];
        substituters = ["https://nix-gaming.cachix.org"];
        trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
    };

    users.users.abyss = {
        isNormalUser = true;
        description = "abyss";
        extraGroups = [ "input" "dbus" "networkmanager" "wheel" ];
    };

    swapDevices = [{
        device = "/swapfile";
        size = 8 * 1024;
    }];
  
    services.printing.enable = true;
    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;
    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.system = "x86_64-linux";
    hardware.bluetooth.enable = true;
}

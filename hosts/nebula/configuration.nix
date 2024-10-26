{ config, pkgs, inputs, ... }:

{
	imports = [
        ./hardware-configuration.nix 
        ./packages.nix
        ../../modules/grub.nix
        ../../modules/networking.nix
        ../../modules/x11.nix
        ../../modules/desktop.nix
        ../../modules/sound.nix
        ../../modules/locale.nix
        ../../modules/gnupg.nix
    ];

    system.stateVersion = "23.05";

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

	services.printing.enable = true;

	programs.zsh.enable = true;
	users.defaultUserShell = pkgs.zsh;

	users.users.abyss = {
		isNormalUser = true;
		description = "abyss";
		extraGroups = [ "input" "dbus" "networkmanager" "wheel" ];
	};

	nixpkgs.config.allowUnfree = true;

	nixpkgs.config.system = "x86_64-linux";
}

{ config, pkgs, inputs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  system.stateVersion = "23.05";

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  boot = {
    loader = {
      efi = { efiSysMountPoint = "/boot/efi"; };
      grub = {
        enable = true;
        efiSupport = true;
        efiInstallAsRemovable = true;
        device = "nodev";
      };
    };
    kernelParams =
      [ "efi_no_storage_paranoia" "resume=/swapfile" "resume_offset=73558016" ];
  };

  hardware = {
    graphics = { enable = true; };
    bluetooth = {
      enable = true;
      powerOnBoot = false;
      settings = { General = { Enable = "Source,Sink,Media,Socket"; }; };
    };
  };

  users = {
    defaultUserShell = pkgs.nushell;

    users.abyss = {
      isNormalUser = true;
      description = "staring into the abyss";
      extraGroups =
        [ "input" "dbus" "networkmanager" "wheel" "pipewire" "audio" "video" ];
      initialPassword = "temp";
    };
  };

  services = {
    blueman.enable = true;
    thermald.enable = true;
    power-profiles-daemon.enable = true;
  };

  powerManagement.enable = true;
}

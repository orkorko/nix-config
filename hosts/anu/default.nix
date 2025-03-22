{ modulesPath, ... }: {
  imports = [ (modulesPath + "/profiles/qemu-guest.nix") ./networking.nix ];

  boot = {
    loader.grub.device = "/dev/vda";
    initrd = {
      availableKernelModules =
        [ "ata_piix" "uhci_hcd" "xen_blkfront" "vmw_pvscsi" ];
      kernelModules = [ "nvme" ];
    };
    tmp.cleanOnBoot = true;
  };

  fileSystems = {
    "/" = {
      device = "/dev/vda1";
      fsType = "ext4";
    };
  };

  zramSwap.enable = true;
  networking.domain = "";
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPqCNcw9BtflX715J3yup/KMWPbF+4GDGC2teoERpuV/ wisp-droplet"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIColoDJNqMP3beu2FWRaPEuLAwBnHsKNJEC4IxHmCr8y u0_a295@localhost"
  ];
  system.stateVersion = "23.11";
}

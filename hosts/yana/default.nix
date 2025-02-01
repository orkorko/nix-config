{ config, lib, ... }: {
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
    kernelModules = [ "kvm-intel" ];
    kernelParams = [
      "efi_no_storage_paranoia"
      "resume=/swapfile"
      "resume_offset=73558016"
    ];
    initrd.availableKernelModules = [
      "vmd"
      "xhci_pci"
      "nvme"
      "usbhid"
    ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/02c0a557-1653-46da-a731-b49c7f970e6d";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/8578-1A81";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };
  };

  swapDevices = [{
    device = "/swapfile";
    size = 8 * 1024;
  }];

  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}

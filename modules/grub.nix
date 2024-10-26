{ config, pkgs, inputs,  ... }:
{
	boot.loader.efi = {
		efiSysMountPoint = "/boot/efi";
	};
	boot.kernelParams = [ "efi_no_storage_paranoia" ];
	boot.loader.grub = {
		enable = true;  
		efiSupport = true;
		efiInstallAsRemovable = true;
		device="nodev";
	};
}

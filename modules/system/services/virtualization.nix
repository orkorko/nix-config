{ lib, config, ... }: lib.mkIf config.isDesktop {
  services.spice-vdagentd.enable = true;
  services.spice-webdavd.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
}

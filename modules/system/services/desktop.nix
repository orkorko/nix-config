{ lib, config, ... }: lib.mkIf config.isDesktop {
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    xkbOptions = "caps:super";
  };
}

{ config, ... }: with config; {
  services = {
    thermald.enable = isDesktop;
    power-profiles-daemon.enable = isDesktop;
  };
  powerManagement.enable = isDesktop;
}

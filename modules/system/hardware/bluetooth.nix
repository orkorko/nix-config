{ config, pkgs, ... }: {
  hardware.bluetooth = {
    enable = config.isDesktop;
    powerOnBoot = false;
    settings = { General = { Enable = "Source,Sink,Media,Socket"; }; };
  };

  services.blueman.enable = config.isDesktop;
}

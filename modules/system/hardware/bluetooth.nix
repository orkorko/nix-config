{ config, ... }: with config; {
  hardware.bluetooth = {
    enable = isDesktop;
    powerOnBoot = false;
    settings = { General = { Enable = "Source,Sink,Media,Socket"; }; };
  };

  services.blueman.enable = isDesktop;
}

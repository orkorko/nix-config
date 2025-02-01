{ config, ... }: {
  hardware.graphics.enable = config.isDesktop;
}

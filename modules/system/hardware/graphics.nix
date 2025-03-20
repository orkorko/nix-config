{ config, ... }: with config; {
  hardware.graphics.enable = isDesktop;
}

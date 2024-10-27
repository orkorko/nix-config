{ config, pkgs, inputs, ... }:
{
    services.xserver = {
        enable = true;
        autorun = false;
        xkb.variant = "";
        videoDrivers = [ "intel " ];
    };
    services.libinput.enable = true;
}

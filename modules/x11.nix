{ config, pkgs, inputs, ... }:
{
    services.xserver = {
        enable = true;
        autorun = false;
        xkb.variant = "";
    };
    services.libinput.enable = true;
}

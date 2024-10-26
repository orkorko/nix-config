{ config, pkgs, inputs, ... }:
{
    services.desktopManager = {
        plasma6.enable = true;
    };

    services.displayManager = {
        sddm.enable = true;
    };
}

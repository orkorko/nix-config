{ config, pkgs, inputs, ... }:
{
    networking = {
	networkmanager.enable = true;
        hostName = "nebula";
        nameservers = [
            "8.8.8.8"
            "8.8.4.4"
        ];
    };
}


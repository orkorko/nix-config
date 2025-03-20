{ lib, hostname, ... }: {
  networking = {
    networkmanager = { enable = true; };
    hostName = hostname;
  };

  programs.mosh = {
    enable = true;
    openFirewall = true;
  };
}

{ pkgs, config, ... }: {
  environment.systemPackages = [ pkgs.tailscale ];
  services.tailscale.enable = true;
  networking.firewall = {
    trustedInterfaces = [ "tailscale0" ];
    allowedUDPPorts = [ 50 config.services.tailscale.port ];
  };
}

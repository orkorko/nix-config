{ pkgs, config, lib, ... }:
lib.mkIf (!config.isDesktop) {
  age.secrets.miniflux.file = ../../../secrets/miniflux.age;
  services.postgresql.enable = true;
  services.nginx.enable = true;

  services.tt-rss = {
    enable = true;
    database = {
      type = "pgsql";
      password = config.age.secrets.miniflux.path; # Set a strong password
    };
    virtualHost = "localhost";
    selfUrlPath = "http://localhost";
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}

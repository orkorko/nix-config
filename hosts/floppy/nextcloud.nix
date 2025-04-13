{ pkgs, config, ... }:
let hostname = "floppy.cat-searobin.ts.net";
in {
  environment.etc."nextcloud-admin-pass".text = "123";
  systemd.tmpfiles.rules = [
    "f /var/lib/nextcloud/config/CAN_INSTALL 0400 nextcloud nextcloud -"
  ];
  age = {
    secrets = {
      nextcloud-admin = {
        file = ../../secrets/nextcloud-admin.password.age;
        owner = "nextcloud";
      };
      floppy-cert = {
        file = ../../secrets/floppy.cert.age;
        mode = "770";
        owner = "nginx";
        group = "nginx";
      };
      floppy-key = {
        file = ../../secrets/floppy.key.age;
        mode = "770";
        owner = "nginx";
        group = "nginx";
      };
    };
  };
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql;
    ensureDatabases = [ "nextcloud" ];
    ensureUsers = [{
      name = "nextcloud";
      ensureDBOwnership = true;
    }];
  };
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud30;
    hostName = hostname;
    database.createLocally = true;
    configureRedis = true;
    maxUploadSize = "4G";
    autoUpdateApps.enable = true;
    extraAppsEnable = true;
    config = {
      dbtype = "pgsql";
      dbname = "nextcloud";
      dbuser = "nextcloud";
      dbhost = "/run/postgresql"; # Socket connection
      adminpassFile = config.age.secrets.nextcloud-admin.path;
    };
    caching = {
      redis = true;
      apcu = true;
    };
    extraApps = with config.services.nextcloud.package.packages.apps; {
      inherit calendar contacts notes news;
      memories = pkgs.fetchNextcloudApp {
        sha256 = "sha256-BfxJDCGsiRJrZWkNJSQF3rSFm/G3zzQn7C6DCETSzw4=";
        url =
          "https://github.com/pulsejet/memories/releases/download/v7.5.2/memories.tar.gz";
        license = "gpl3";
      };
    };
    settings.overwriteprotocol = "https";
  };
  services.nginx.virtualHosts."${hostname}" = {
    forceSSL = true;
    sslCertificate = config.age.secrets.floppy-cert.path;
    sslCertificateKey = config.age.secrets.floppy-key.path;
  };
}

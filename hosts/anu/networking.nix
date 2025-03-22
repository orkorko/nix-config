{ lib, ... }: {
  networking = {
    nameservers = [ "8.8.8.8" ];
    defaultGateway = "139.59.64.1";
    defaultGateway6 = {
      address = "";
      interface = "eth0";
    };
    dhcpcd.enable = false;
    usePredictableInterfaceNames = lib.mkForce false;
    interfaces = {
      eth0 = {
        ipv4.addresses = [
          {
            address = "139.59.67.117";
            prefixLength = 20;
          }
          {
            address = "10.47.0.5";
            prefixLength = 16;
          }
        ];
        ipv6.addresses = [{
          address = "fe80::ccb:7fff:fe61:202a";
          prefixLength = 64;
        }];
        ipv4.routes = [{
          address = "139.59.64.1";
          prefixLength = 32;
        }];
        ipv6.routes = [{
          address = "";
          prefixLength = 128;
        }];
      };
      eth1 = {
        ipv4.addresses = [{
          address = "10.122.0.2";
          prefixLength = 20;
        }];
        ipv6.addresses = [{
          address = "fe80::38da:45ff:fed2:535f";
          prefixLength = 64;
        }];
      };
    };
  };
  services.udev.extraRules = ''
    ATTR{address}=="0e:cb:7f:61:20:2a", NAME="eth0"
    ATTR{address}=="3a:da:45:d2:53:5f", NAME="eth1"
  '';
}

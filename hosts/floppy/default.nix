{ modulesPath, lib, ... }:
{
  imports = lib.optional (builtins.pathExists ./do-userdata.nix) ./do-userdata.nix ++ [
    (modulesPath + "/virtualisation/digital-ocean-config.nix")
    ./nextcloud.nix
  ];

  nix.optimise = {
    automatic = true;
    dates = [ "03:30" ];
  };
}

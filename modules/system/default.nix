{
  pkgs,
  lib,
  modulesPath,
  stateVersion, 
  system,
  hostname,
  username,
  config,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./base
    ./services
    ./hardware
  ];
  system = { inherit stateVersion; };
  nix = { settings = { experimental-features = [ "nix-command" "flakes" ]; }; };
  users = {
    defaultUserShell = pkgs.nushell;
    users."${username}" = {
      isNormalUser = true;
      description = username;
      initialPassword = "temp";
      extraGroups = [ "input" "networkmanager" "wheel" "dbus" ]
        ++ lib.optionals config.isDesktop [ "audio" "video" "pipewire" ];
    };
  };
}

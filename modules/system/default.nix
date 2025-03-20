{
  self,
  pkgs,
  lib,
  modulesPath,
  stateVersion, 
  system,
  hostname,
  username,
  config,
  ...
}: let
  timestamp = builtins.readFile (pkgs.runCommand "format-time" {} ''
    bash -c 'date "+%Y-%m-%d-%S" > $out'
  '');
in {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./base
    ./services
    ./hardware
  ];

  system = { inherit stateVersion; };

  home-manager.backupFileExtension = timestamp;

  nix = {
    settings = { 
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  age = {
    identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    secrets.${username} = {
      file = ../../secrets/${username}.password.age;
      owner = username;
      mode = "600";
    };
  };

  users = {
    defaultUserShell = pkgs.nushell;
    users."${username}" = {
      isNormalUser = true;
      description = username;
      hashedPasswordFile = config.age.secrets.${username}.path;
      extraGroups = [ "input" "networkmanager" "wheel" "dbus" ]
        ++ lib.optionals config.isDesktop [ "audio" "video" "pipewire" ];
    };
  };
}

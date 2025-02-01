{ config, lib, username, stateVersion, ... }: {
  imports = [ ./cli ./dev ./editors ./desktop ];

  home = {
    inherit username stateVersion;
    homeDirectory = "/home/${username}";
  };
}

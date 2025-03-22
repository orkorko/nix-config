{ isDesktop, lib, username, stateVersion, ... }: {
  # @todo: imports are evaulated before options so this is a (temporary?)
  # workaround for now
  imports = [ ./cli ./dev ./editors ./services ]
            ++ lib.optionals isDesktop [ ./desktop ];
  home = {
    inherit username stateVersion;
    homeDirectory = "/home/${username}";
  };
}

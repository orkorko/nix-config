{ config, lib, ... }: {
  programs.ssh = {
    enable = true;
    controlMaster = "auto";
    controlPath = "~/.ssh/control/%r@%h-%p";
    controlPersist = "30m";
    serverAliveCountMax = 2;
    serverAliveInterval = 60;
    KbdInteractiveAuthentication = false;
    matchBlocks = {
      "*" = {
        setEnv.COLORTERM = "truecolor";
        setEnv.TERM      = "xterm-256color";
        identityFile = "~/.ssh/id";
      };
    };
  };
  home.packages = lib.optional config.isDesktop mosh;
}

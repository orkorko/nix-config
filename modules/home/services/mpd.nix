{ pkgs, lib, config, ... }:
lib.mkIf config.isDesktop {
  home.packages = with pkgs; [ ncmpcpp snapcast ];
  services.mpd = {
    enable = true;
    musicDirectory = "~/music";
    extraConfig = ''
      # must specify one or more outputs in order to play audio!
      # (e.g. ALSA, PulseAudio, PipeWire), see next sections
    '';
    network.listenAddress = "any";
  };
}

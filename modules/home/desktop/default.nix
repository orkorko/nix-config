{ pkgs, config, lib, ... }: {
  imports = [
    ./river
    ./gtk.nix
    ./librewolf.nix
    ./ghostty.nix
  ];

  home.packages = with pkgs; [
    liferea
    hexedit
    krita
    gimp
    mpv
    zulip
    discord
    chromium
    nicotine-plus
    feh
    nitrogen
    wlroots
  ];
}

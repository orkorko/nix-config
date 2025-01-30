{ pkgs, ... }: {
  imports = [
    ./river
    ./emacs
    ./gtk.nix
    ./librewolf.nix
    ./ghostty.nix
    ./dunst.nix
    ./nvim.nix
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

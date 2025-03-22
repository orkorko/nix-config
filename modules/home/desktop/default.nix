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
    hexchat
    krita
    gimp
    mpv
    zulip
    discord
    nicotine-plus
    feh
    nitrogen
    zathura
    pavucontrol
    zed-editor
    chromium
    pcmanfm
    obsidian
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    brave
  ];
}

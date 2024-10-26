{ pkgs, ... }:
{
    home.packages = with pkgs; [
        tmux
        chromium
        alacritty
        pcmanfm
        xclip
        zathura
        gimp
        inkscape
        kakoune
        zulip
        discord
        obs-studio
        simplescreenrecorder
        libreoffice
        (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
}


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
        protonup-qt
        p7zip
        liferea
        element-desktop
        fractal
        claws-mail
        neomutt
        notmuch
        mutt-wizard
        pass
        isync
        hexedit
        (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
}


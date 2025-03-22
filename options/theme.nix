# CREDITS: https://github.com/RGBCube/NCC/blob/master/options/theme.nix
{ themes, lib, pkgs, ... }:
let base = themes.raw.gruvbox-dark-hard;
in {
  options.theme = lib.mkValue (themes.custom (base // {
    margin = 2;
    padding = 4;

    font.size.normal = 12;
    font.size.big = 16;

    font.sans.name = "Inter";
    font.sans.package = pkgs.inter;

    font.mono.name = "Iosevka Nerd Font";
    font.mono.package = pkgs.nerd-fonts.iosevka;

    icons.name = "Gruvbox-dark-icons";
    icons.package = pkgs.gruvbox-dark-icons-gtk;

    cursor.name = "Capitaine Cursors";
    cursor.size = 20;
    cursor.package = pkgs.capitaine-cursors;
  }));
}

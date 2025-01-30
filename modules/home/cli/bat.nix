{ config, pkgs, ... }:
{
  programs.bat = {
    enable = true;
    config.theme = "base16";
    themes.base16.src = pkgs.writeText "base16.tmTheme" config.theme.tmTheme;
  };
}

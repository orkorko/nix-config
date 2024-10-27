{ config, pkgs, ... }:
{
    programs.alacritty = {
        enable = true;
        settings = {
            font = {
                normal.family = "BerkeleyMonoNerdFont";
                size = 10.5;
            };
            window.opacity = 0.95;
            colors.primary = {
                background = "#1d2021";
                foreground = "#d4be98";
            };
            colors.normal = {
                black   = "#32302f";
                red     = "#ea6962";
                green   = "#a9b665";
                yellow  = "#d8a657";
                blue    = "#7daea3";
                magenta = "#d3869b";
                cyan    = "#89b482";
                white   = "#d4be98";
            };
            colors.bright = {
                black   = "#32302f";
                red     = "#ea6962";
                green   = "#a9b665";
                yellow  = "#d8a657";
                blue    = "#7daea3";
                magenta = "#d3869b";
                cyan    = "#89b482";
                white   = "#d4be98";
            };
        };
    };
}


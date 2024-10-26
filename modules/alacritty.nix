{ config, pkgs, ... }:
{
    programs.alacritty = {
        enable = true;
        settings = {
            font = {
                normal.family = "JetbrainsMonoNerdFont";
            };
            window.opacity = 0.95;
        };
    };
}


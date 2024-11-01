{ config, inputs, pkgs, ... }:
{
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        syntaxHighlighting.enable = true;

        history = {
            size = 10000;
            path = "${config.xdg.dataHome}/zsh/history";
        };

        oh-my-zsh = {
            enable = true;
            plugins = [ "git" ];
            theme = "lambda";
        };

        shellAliases = {
            vim = "nvim";
            vi = "nvim";
            gho = ''xdg-open $(git remote get-url origin | sed "s/.*://" | awk '{print "https://github.com/" $0}')'';
        };
    };
}


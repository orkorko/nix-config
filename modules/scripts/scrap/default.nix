{ config, pkgs, ... }:
{
    home.packages = [
        (pkgs.writeShellScriptBin "gwern-pages" "${builtins.readFile ./gwern-pages.sh}")
        (pkgs.writeShellScriptBin "gwern-sitemap" "${builtins.readFile ./gwern-sitemap.sh}")
        (pkgs.writeShellScriptBin "gwern-to-rss" "${builtins.readFile ./gwern-to-rss.sh}")
        (pkgs.writeShellScriptBin "urls-to-rss" "${builtins.readFile ./urls-to-rss.sh}")
    ];
}



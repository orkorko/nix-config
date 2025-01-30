{ pkgs, ... }:
{
  imports = [
    ./nushell
    ./gnupg.nix
    ./git.nix
    ./bat.nix
    ./rg.nix
  ];

  home.packages = with pkgs; [
    home-manager
    cowsay
    fastfetch
    asciinema
    tree
    p7zip
    rsync
    yt-dlp
    tmux
    fd
  ];
}

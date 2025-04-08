{ pkgs, ... }: {
  imports = [
    ./nushell
    ./git.nix
    ./bat.nix
    ./ripgrep.nix
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
    wakatime-cli
    wakatime
    util-linux
    exfatprogs
  ];
}

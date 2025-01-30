{ pkgs, ... }: {
  home.packages = [ pkgs.git-lfs ];
  programs.git = {
    enable = true;
    userName = "nandv";
    userEmail = "heynandv@gmail.com";
    extraConfig = { init = { defaultBranch = "master"; }; };
  };
}

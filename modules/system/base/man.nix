{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    linux-manual
    man-pages
    man-pages-posix
    clang-manpages
  ];
  documentation = {
    enable = true;
    man = {
      enable = true;
      # generateCaches = true;
    };
    dev.enable = true;
  };
}

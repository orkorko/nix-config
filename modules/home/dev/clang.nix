{ pkgs, ... }: {
  home.packages = [
    pkgs.clang_16
    pkgs.clang-tools_16
  ];
}

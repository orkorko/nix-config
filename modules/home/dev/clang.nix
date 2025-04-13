{ pkgs, lib, config, ... }: {
  home.packages = with pkgs; [
    clang_16
    linuxPackages.perf
  ] ++ lib.optionals config.isDesktop [
    clang-tools_16
    valgrind
    gdb
    lldb
    # versions of ld required by gcc and clang conflict
    # see: https://github.com/nix-community/home-manager/issues/1668#issuecomment-1264298055
    (hiPrio gcc)
  ];
}

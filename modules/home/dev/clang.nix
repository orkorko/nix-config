{ pkgs, ... }: {
  home.packages = with pkgs; [
    clang_16
    clang-tools_16
    valgrind
    gdb
    lldb
    linuxPackages.perf
    # versions of ld required by gcc and clang conflict
    # see: https://github.com/nix-community/home-manager/issues/1668#issuecomment-1264298055
    (hiPrio gcc)
  ];
}

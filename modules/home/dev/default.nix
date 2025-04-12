{ pkgs, ... }:
{
  imports = [ ./clang.nix ./python.nix ];

  home.packages = with pkgs; [
    ghc
    go
    zig
    jdk
    lld
    maven
    deno
    strace
    usbutils
    hyperfine
    julia
    nixfmt-classic
    cabal-install
    agda
    racket
    rustc
    cargo
  ];
}

{ lib, pkgs, config, ... }:
{
  imports = [ ./clang.nix ./python.nix ];

  home.packages = lib.optionals config.isDesktop (with pkgs; [
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
  ]);
}

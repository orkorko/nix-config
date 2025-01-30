{ pkgs, ... }: {
  imports = [
    ./man.nix
    ./sound.nix
    ./networking.nix
    ./openssh.nix
    ./locale.nix
  ];
}

{ pkgs, config, ... }: {
  imports = [
    ./cli
    ./dev
    ./desktop
    ./theme
  ];
}

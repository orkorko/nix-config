{ themes, lib, pkgs, ... }: {
  theme = import ./themes.nix { inherit themes lib pkgs; };
}

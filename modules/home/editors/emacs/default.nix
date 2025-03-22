{ lib, config, pkgs, ... }:
let
  emacsPkgs = epkgs: [
    epkgs.use-package
    epkgs.meow
    epkgs.gruvbox-theme
    epkgs.consult
    epkgs.vertico
    epkgs.orderless
    epkgs.wakatime-mode
    epkgs.haskell-mode
    epkgs.nix-mode
    epkgs.nixfmt
    epkgs.magit
    epkgs.nushell-mode
    epkgs.agda2-mode
  ];
in lib.mkIf config.isDesktop {
  home.packages = [
    (pkgs.emacsWithPackagesFromUsePackage {
      package = pkgs.emacs;
      config = ./emacs.el;
      defaultInitFile = true;
      alwaysEnsure = true;
      extraEmacsPackages = emacsPkgs;
    })
    pkgs.fzf
  ];

  services.emacs = {
    enable = true;
    package =
      (pkgs.emacsPackagesFor pkgs.emacs).emacsWithPackages (emacsPkgs);
  };
}

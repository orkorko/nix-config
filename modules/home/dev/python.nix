{ pkgs, ... }: {
  home.packages = [
    (pkgs.python311.withPackages (pkgs: [
      pkgs.pip
      pkgs.requests
    ]))
    pkgs.uv
    pkgs.ruff
  ];
}

{ config, pkgs, ... }:
{
  home.packages = [
    (pkgs.writeShellScriptBin "tmux-sessionizer" ''
      ${builtins.readFile ./tmux-sessionizer.sh}
    '')
  ];
}


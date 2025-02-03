{ pkgs, lib, config, ... }: {
  imports = [ ./starship.nix ];

  home.packages = with pkgs; [ fish carapace ];

  home.activation.setup-carapace = lib.hm.dag.entryAfter [ "installPackages" "writeBoundary" ] ''
      mkdir -p ${config.home.homeDirectory}/.cache/carapace
      echo "$(carapace _carapace nushell)" > ${config.home.homeDirectory}/.cache/carapace/init.nu
    '';

  programs.nushell = {
    enable = true;
    shellAliases = {
      vim = "nvim";
      vi = "nvim";
      op = ''/home/abyss/code/openpilot/tools/op.sh "$@"'';
    };
    settings = {
      show_banner = false;
      buffer_editor = "hx";
      completions.external = {
        enable = true;
        max_results = 100;
      };
    };
    environmentVariables = {
      EDITOR = "hx";
    };
    extraLogin = lib.mkIf config.isDesktop ''
      if (tty) == '/dev/tty1' {
         exec river
      }
    '';
    extraConfig = ''
      print "do improve win";
      $env.CARAPACE_BRIDGES = "fish,bash,inshellisense";
      let carapace_completer = {|spans|
          carapace $spans.0 nushell ...$spans | from json
      }
      source ~/.cache/carapace/init.nu
    '';
  };
}

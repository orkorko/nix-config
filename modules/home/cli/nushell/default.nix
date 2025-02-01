{ pkgs, lib, config, ... }: {
  imports = [ ./starship.nix ];

  home.packages = with pkgs; [ fish carapace ];

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
      CARAPACE_BRIDGES = "fish,bash,inshellisense";
    };
    extraLogin = lib.mkIf config.isDesktop ''
      if (tty) == '/dev/tty1' {
         exec river
      }
    '';
    extraConfig = ''
      print "do improve win";
      let carapace_completer = {|spans|
          carapace $spans.0 nushell ...$spans | from json
      }
      source ~/.cache/carapace/init.nu
    '';
  };
}

{ pkgs, ... }: {
  imports = [ ./starship.nix ];

  home.packages = [ pkgs.fish pkgs.carapace ];
  
  programs.nushell = {
    enable = true;

    shellAliases = {
      vim = "nvim";
      vi = "nvim";
      op = ''/home/abyss/code/openpilot/tools/op.sh "$@"'';
    };

    extraConfig = ''
      print "do improve win";

      let carapace_completer = {|spans|
          carapace $spans.0 nushell ...$spans | from json
      }

      $env.config.completions.external = {
          enable: true
          max_results: 100
          completer: $carapace_completer
      }

      $env.config.buffer_editor = "nvim";
      $env.config.show_banner = false;

      $env.CARAPACE_BRIDGES = 'fish,bash,inshellisense'
      source ~/.cache/carapace/init.nu
    '';
  };

}

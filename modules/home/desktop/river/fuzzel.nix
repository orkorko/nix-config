{ config, lib, ... }: with config.theme; {
  programs.fuzzel = {
    enable = true;
    settings.main = {
      dpi-aware = false;
      font = "${font.mono.name}:size=${toString font.size.normal}";
      terminal = "ghostty -e";
      tabs = 4;
      horizontal-pad = padding;
      vertical-pad = padding;
      inner-pad = padding;
    };
    settings.colors = lib.mapAttrs (lib.const (color: "${color}FF")) {
      background = base00;
      text = base05;
      input-color = base05;
      match = base0A;
      selection = base05;
      selection-text = base00;
      border = base0A;
    };
  };
}

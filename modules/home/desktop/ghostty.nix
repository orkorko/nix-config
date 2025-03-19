{ config, pkgs, lib, ... }: with lib; {
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty;
    settings = with config.theme; {
      font-size = font.size.normal;
      font-family = font.mono.name;
      confirm-close-surface = false;
      quit-after-last-window-closed = false;
      clipboard-paste-protection = false;
      gtk-wide-tabs = false;
      gtk-titlebar = false;
      window-decoration = false;
      cursor-style = "block";
      cursor-style-blink = false;
      shell-integration-features = "sudo";
      keybind = (mapAttrsToList (name: value: "ctrl+shift+${name}=${value}") {
        left_bracket = "goto_split:previous";
        right_bracket = "goto_split:next";
        h = "resize_split:left,10";
        l = "resize_split:right,10";
        j = "resize_split:down,10";
        k = "resize_split:up,10";
      });
      config-file = toString (pkgs.writeText "base16-config" ghosttyConfig);
    };
  };
}

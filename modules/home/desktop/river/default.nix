{ config, pkgs, lib, ... }:

let
  terminal = "ghostty";
  editor = "emacsclient -c -a 'emacs'";
  browser = "librewolf";

  shl = x: if x <= 0 then 1 else 2 * (shl (x - 1));
  allTags = (shl 32) - 1;
in with config.theme; {
  home.packages =
    [ pkgs.brightnessctl pkgs.swaybg pkgs.xfce.xfce4-power-manager pkgs.gcr ];

  services.gnome-keyring.enable = true;

  programs.fuzzel = {
    enable = true;
    settings.main = {
      dpi-aware = false;
      font = "${font.mono.name}:size=${toString font.size.normal}";
      terminal = "${terminal} -e";
      tabs = 4;
      horizontal-pad = padding;
      vertical-pad = padding;
      inner-pad = padding;
    };

    # Make sure your colors have alpha in RGBA, or just append 'FF'
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

  wayland.windowManager.river = {
    enable = true;
    package = pkgs.river;
    xwayland.enable = true;
    systemd.enable = true;

    extraSessionVariables = { MOZ_ENABLE_WAYLAND = "1"; };

    settings = {
      "background-color" = "0x${base00}";
      "border-color-focused" = "0x${base0A}";
      "border-color-unfocused" = "0x${base03}";
      "keyboard-layout" = "-options 'caps:super' 'us'";
      "set-repeat" = "80 250";
      "output-layout" = "rivertile";

      # Startup commands
      spawn = [
        "rivertile"
        "emacs --daemon"
        "kwalletd6"
        "dunst"
        "xfce4-power-manager"
        "mpd"
        "rivertile -view-padding ${toString padding} -outer-padding ${
          toString padding
        }"
        "gnome-keyring-daemon --start --components=secrets,ssh"
        ''wlr-randr --output "HDMI-A-1" --mode 1920x1080@100''
      ];

      # Standard keybinds in the normal mode:
      map.normal = {
        "Super 0" = "set-focused-tags ${toString allTags}";
        "Super+Shift 0" = "set-focused-tags ${toString allTags}";
        "Super Return" = "spawn ${terminal}";
        "Super E" = ''spawn "${editor}"'';
        "Super B" = "spawn ${browser}";
        "Super Q" = "close";

        "Super J" = "focus-view next";
        "Super K" = "focus-view previous";
        "Super+Shift J" = "swap next";
        "Super+Shift K" = "swap previous";

        "Super Period" = "focus-output next";
        "Super Comma" = "focus-output previous";
        "Super+Shift Period" = "send-to-output next";
        "Super+Shift Comma" = "send-to-output previous";

        "Super+Shift Return" = "zoom";

        "Super H" = "send-layout-cmd rivertile 'main-ratio -0.05' ";
        "Super L" = "send-layout-cmd rivertile 'main-ratio +0.05' ";

        "Super+Shift H" = "send-layout-cmd rivertile 'main-count +1' ";
        "Super+Shift L" = "send-layout-cmd rivertile 'main-count -1' ";

        "Super+Alt H" = "move left 100";
        "Super+Alt J" = "move down 100";
        "Super+Alt K" = "move up 100";
        "Super+Alt L" = "move right 100";

        "Super+Alt+Control H" = "snap left";
        "Super+Alt+Control J" = "snap down";
        "Super+Alt+Control K" = "snap up";
        "Super+Alt+Control L" = "snap right";

        "Super+Alt+Shift H" = "resize horizontal -100";
        "Super+Alt+Shift J" = "resize vertical 100";
        "Super+Alt+Shift K" = "resize vertical -100";
        "Super+Alt+Shift L" = "resize horizontal 100";

        "Super P" = "spawn fuzzel";

        "Super Apostrophe" =
          ''spawn "pactl -- set-sink-volume @DEFAULT_SINK@ +5%"'';
        "Super+Shift Apostrophe" =
          ''spawn "pactl -- set-sink-volume @DEFAULT_SINK@ -5%"'';

        "Super Space" = "toggle-float";
        "Super F" = "toggle-fullscreen";

        "Super Up" = "send-layout-cmd rivertile 'main-location top' ";
        "Super Right" = "send-layout-cmd rivertile 'main-location right' ";
        "Super Down" = "send-layout-cmd rivertile 'main-location bottom' ";
        "Super Left" = "send-layout-cmd rivertile 'main-location left' ";

        "Super+Shift Slash" = ''spawn "brightnessctl set 5%-" '';
        "Super Slash" = ''spawn "brightnessctl set 5%+" '';
      } // lib.foldl' (acc: x:
        let tag = shl x;
        in acc // {
          "Super ${toString x}" = "set-focused-tags ${toString tag}";
          "Super+Shift ${toString x}" = "set-view-tags ${toString tag}";
          "Super+Control ${toString x}" = "toggle-focused-tags ${toString tag}";
          "Super+Shift+Control ${toString x}" =
            "toggle-view-tags ${toString tag}";
        }) { } (lib.range 1 9);

      # For pointer usage:
      map-pointer.normal = {
        "Super BTN_LEFT" = "move-view";
        "Super BTN_RIGHT" = "resize-view";
        "Super BTN_MIDDLE" = "toggle-float";
      };

      # Touchpad settings:
      input."*Touchpad" = {
        natural-scroll = "enabled";
        tap = "enabled";
      };

      # Window rules:
      "rule-add"."-app-id '*'" = "ssd";

      declare-mode = [ "locked" "normal" ];
    };
  };
}

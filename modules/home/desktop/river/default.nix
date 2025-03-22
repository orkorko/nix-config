{ config, pkgs, lib, ... }:

let
  shl = x: if x <= 0 then 1 else 2 * (shl (x - 1));
  allTags = (shl 32) - 1;
  
in with config.theme; {
  imports = [
    ./dunst.nix
    ./fuzzel.nix
  ];
  
  home.packages = [
    pkgs.brightnessctl
    pkgs.swaybg
    pkgs.xfce.xfce4-power-manager
    pkgs.gcr
    cursor.package
  ];

  services.gnome-keyring.enable = true;

  wayland.windowManager.river = {
    enable = true;
    package = pkgs.river;
    xwayland.enable = true;
    systemd.enable = true;

    extraSessionVariables = { MOZ_ENABLE_WAYLAND = "1"; };

    settings = {
      "background-color" = with0x.base00;
      "border-color-focused" = with0x.base0A;
      "border-color-unfocused" = with0x.base03;
      "keyboard-layout" = "-options 'caps:super' 'us'";
      "set-repeat" = "80 250"; # buttery smooooth
      "default-layout" = "rivertile";
      "xcursor-theme" = "${cursor.name} ${toString cursor.size}";

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
        "'nu -c 'sleep 5sec; wlr-randr --output \"HDMI-A-1\" --mode 1920x1080@100''"
      ];

      map.normal = {
        "Super 0" = "set-focused-tags ${toString allTags}";
        "Super+Shift 0" = "set-focused-tags ${toString allTags}";
        "Super Return" = "spawn ghostty";
        "Super E" = ''spawn "emacsclient -c -a 'emacs'"'';
        "Super B" = "spawn librewolf";
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

        "Super H" = "send-layout-cmd rivertile 'main-ratio -0.05'";
        "Super L" = "send-layout-cmd rivertile 'main-ratio +0.05'";

        "Super+Shift H" = "send-layout-cmd rivertile 'main-count +1'";
        "Super+Shift L" = "send-layout-cmd rivertile 'main-count -1'";

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
          ''spawn "wpctl set-volume @DEFAULT_SINK@ 5%+"'';
        "Super+Shift Apostrophe" =
          ''spawn "wpctl set-volume @DEFAULT_SINK@ 5%-"'';

        "Super Space" = "toggle-float";
        "Super F" = "toggle-fullscreen";

        "Super Up" = "send-layout-cmd rivertile 'main-location top' ";
        "Super Right" = "send-layout-cmd rivertile 'main-location right' ";
        "Super Down" = "send-layout-cmd rivertile 'main-location bottom' ";
        "Super Left" = "send-layout-cmd rivertile 'main-location left' ";

        "Super+Shift Slash" = ''spawn "brightnessctl set 5%-" '';
        "Super Slash" = ''spawn "brightnessctl set 5%+" '';
      } // lib.foldl' (acc: x:
        let tag = shl (x - 1);
        in acc // {
          "Super ${toString x}" = "set-focused-tags ${toString tag}";
          "Super+Shift ${toString x}" = "set-view-tags ${toString tag}";
          "Super+Control ${toString x}" = "toggle-focused-tags ${toString tag}";
          "Super+Shift+Control ${toString x}" =
            "toggle-view-tags ${toString tag}";
        }) { } (lib.range 1 9);

      map-pointer.normal = {
        "Super BTN_LEFT" = "move-view";
        "Super BTN_RIGHT" = "resize-view";
        "Super BTN_MIDDLE" = "toggle-float";
      };

      input."*Touchpad" = {
        natural-scroll = "enabled";
        tap = "enabled";
      };

      "rule-add"."-app-id '*'" = "ssd";

      declare-mode = [ "locked" "normal" ];
    };
  };
}

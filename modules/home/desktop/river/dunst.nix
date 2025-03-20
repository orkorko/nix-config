{ config, ... }: {
  services.dunst = with config.theme.withHashtag; {
    enable = true;
    settings.global = {
      width = "(300, 800)";
      dmenu = "fuzzel --dmenu";
      gap_size = margin;
      horizontal_padding = padding;
      padding = padding;
      frame_color = base0A;
      separator_color = "frame";
      background = base00;
      foreground = base05;
      alignment = "left";
      font = "${font.sans.name} ${toString font.size.normal}";
      origin = "top-right";
    };
    settings.urgency_low = {
      frame_color = base0A;
      timeout = 5;
    };
    settings.urgency_normal = {
      frame_color = base09;
      timeout = 10;
    };
    settings.urgency_critical = {
      frame_color = base08;
      timeout = 15;
    };
  };
}

{ config, pkgs, hm, ... }:
with config.theme; {
  home.packages = [ pkgs.dconf ];
  
  dconf.enable = true;

  fonts.fontconfig = {
    enable = true;
    defaultFonts = with font; {
      sansSerif = [ sans.name ];
      monospace = [ mono.name ];
    };
  };

  home.pointerCursor = with cursor; {
    inherit name size package;
    gtk.enable = true;
  };
    
  xdg.configFile."gtk-3.0/settings.ini".text = ''
      [Settings]
      gtk-enable-key-repeat=true
      gtk-key-repeat-delay=80
      gtk-key-repeat-interval=250
  '';
    
  xdg.configFile."gtk-4.0/settings.ini".text = ''
      [Settings]
      gtk-enable-key-repeat=true
      gtk-key-repeat-delay=80
      gtk-key-repeat-interval=250
  '';
    
  gtk = {
      enable = true;
      iconTheme = icons;
      cursorTheme = cursor;

      font = with font; {
          inherit (sans) name package;
          size = size.normal;
      };

      theme = {
          name = "Adwaita-dark";
          package = pkgs.gnome-themes-extra;
      };
  };
}

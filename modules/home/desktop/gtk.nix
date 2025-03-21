{ config, pkgs, hm, ... }:
let
  gtkCss = ''
    headerbar.default-decoration {
      margin-bottom: 50px;
      margin-top: -100px;
    }

    /* rm -rf window shadows */
    window.csd,             /* gtk4? */
    window.csd decoration { /* gtk3 */
      box-shadow: none;
    }

    ${config.theme.adwaitaGtkCss}
'';

in with config.theme; {
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
    
  gtk = {
    enable = true;
    gtk3.extraCss = gtkCss;
    gtk4.extraCss = gtkCss;
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

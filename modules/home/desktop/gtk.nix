{ config, pkgs, hm, ... }:
let
  gtkCss = ''
    /* No (default) title bar on wayland */
    headerbar.default-decoration {
      /* You may need to tweak these values depending on your GTK theme */
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
  dconf.enable = false;

  fonts.fontconfig = {
    enable = true;
    defaultFonts = with font; {
      sansSerif = [ sans.name ];
      monospace = [ mono.name ];
    };
  };

  gtk = {
    enable = true;
    gtk3.extraCss = gtkCss;
    gtk4.extraCss = gtkCss;
    iconTheme = icons;

    font = with config.theme.font; {
      inherit (sans) name package;
      size = size.normal;
    };

    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };
}

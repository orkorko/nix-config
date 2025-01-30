{ config, pkgs, ... }: {
  programs.librewolf = {
    enable = true;
    settings = {
      "general.autoScroll" = true;
      "privacy.donottrackheader.enabled" = true;
      "browser.fixup.domainsuffixwhitelist.idk" = true;
      #"font.name.serif.x-western" = font.sans;
      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    };
    # userChrome = ''
    #     ${firefoxTheme}
    #     #TabsToolbar {
    #         visibility: collapse;
    #     }
    #     '';
  };
}

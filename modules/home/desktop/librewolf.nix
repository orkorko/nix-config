{ config, ... }: with config.theme; {
  programs.librewolf = {
    enable = true;
    settings = {
      "general.autoScroll" = true;
      "privacy.donottrackheader.enabled" = true;
      "browser.fixup.domainsuffixwhitelist.idk" = true;
      "font.name.serif.x-western" = font.sans.name;
      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    };
  };
}

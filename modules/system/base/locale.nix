{ lib, pkgs, ... }: {
  time.timeZone = "Asia/Kolkata";
  
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = lib.genAttrs [
      "LC_ADDRESS"
      "LC_IDENTIFICATION"
      "LC_MEASUREMENT"
      "LC_MONETARY"
      "LC_NAME"
      "LC_NUMERIC"
      "LC_PAPER"
      "LC_TELEPHONE"
      "LC_TIME"
      "LANG"
      "LC_AL"
    ] (lib.const "en_US.UTF-8");
  };
}

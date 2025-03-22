{ config, pkgs, lib, ... }:
let
  port = "4445";
  web-dir = pkgs.element-web.override {
    conf = {
      default_server_config = "http://localhost:4444";
      default_theme = "dark";
      show_labs_settings = true;
    };
  };
  element-web = pkgs.writeScriptBin "element-web" ''
    #!${pkgs.bash}/bin/bash
    set -e
    ${pkgs.python3}/bin/python3 -m http.server ${port} -b ::1 -d ${web-dir}
  '';
in lib.mkIf (!config.isDesktop) { home.sessionPath = [ "${element-web}/bin" ]; }

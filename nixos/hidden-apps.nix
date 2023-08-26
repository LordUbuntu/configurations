# Thanks to Max Headroom for the help
# See: https://git.privatevoid.net/max/config
{ config, lib, pkgs, ... }:
let
  inherit (config.desktop) hiddenApps;

  hiddenDesktopFile = pkgs.writeText "hidden.desktop" ''
    [Desktop Entry]
    Hidden=true
    NoDisplay=true
  '';
  hiddenAppsPackage = pkgs.runCommandLocal "hidden-apps" {} ''
    mkdir -p $out/share/applications
    for app in ${lib.escapeShellArgs hiddenApps}; do
      ln -sf ${hiddenDesktopFile} "$out/share/applications/$app"
    done
  '';
in
{
  options.desktop = {
    hiddenApps = lib.mkOption {
      type = with lib.types; listOf str;
      default = [];
    };
  };
  config = lib.mkIf (hiddenApps != []) {
    environment.systemPackages = [
      (lib.hiPrio hiddenAppsPackage)
    ];
  };
}

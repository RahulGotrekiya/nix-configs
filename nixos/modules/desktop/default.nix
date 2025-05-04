{ config, pkgs, lib, ... }:

let
  desktopEnvironment = "gnome"; # or "kde", or "none"

  gnome = import ./gnome.nix;
  kde = import ./kde.nix;
  common = import ./common.nix;

  selectedDE =
    if desktopEnvironment == "gnome" then gnome
    else if desktopEnvironment == "kde" then kde
    else {};

in
{
  imports = [
    common
    selectedDE
  ];

  services.displayManager.autoLogin = {
    enable = false;
    user = "rahul";
  };
}

{ config, pkgs, ... }:

{
  # Enable Flatpak service
  services.flatpak.enable = true;

  # Install flatpak package
  environment.systemPackages = with pkgs; [
    flatpak
  ];
}
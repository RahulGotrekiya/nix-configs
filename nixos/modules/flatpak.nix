{ config, pkgs, ... }:

{
  # Enable Flatpak service
  services.flatpak.enable = true;

  # Install flatpak package
  environment.systemPackages = with pkgs; [
    flatpak
  ];

  # Add Flathub repository automatically (optional but recommended)
  system.activationScripts.flatpak-flathub = ''
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  '';
}
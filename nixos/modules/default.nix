{ config, pkgs, ... }:

{
  imports = [
    ./system.nix
    ./desktop.nix
    ./services.nix
    ./packages.nix
    ./users.nix
    ./networking.nix
    ./flatpak.nix
  ];
}

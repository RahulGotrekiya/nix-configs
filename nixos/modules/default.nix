{ config, pkgs, ... }:

{
  imports = [
    ./system.nix
    ./services.nix
    ./packages.nix
    ./users.nix
    ./networking.nix
    ./flatpak.nix
    ./wm.nix 
    ./desktop
  ];
}

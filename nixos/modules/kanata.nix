{ config, lib, pkgs, ... }:

{
  # Load the uinput kernel module at boot
  boot.kernelModules = [ "uinput" ];
  
  # Create the uinput group if it doesn't exist
  users.groups.uinput = {};
  
  # Set udev rules for uinput
  services.udev.extraRules = ''
    # Kanata keyboard remapping tool
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';
  
  # Install kanata system-wide
  environment.systemPackages = with pkgs; [
    kanata
  ];
}
# Desktop environment configuration with selected apps
# This file contains settings for GNOME/KDE and their respective applications

{ config, pkgs, ... }:

let
  # Change this value to switch between desktop environments
  # Options: "gnome", "kde", or "none" (for minimal/no DE)
  desktopEnvironment = "kde";
  
  # GNOME-specific applications
  gnomeApps = with pkgs; [
    gnome-tweaks
  ];
  
  # KDE-specific applications
  kdeApps = with pkgs; [
    kdePackages.kate
    kdePackages.konsole
    kdePackages.dolphin # File manager
    kdePackages.okular # Document viewer
    kdePackages.gwenview # Image viewer
    kdePackages.ark # Archive manager
    kdePackages.kcalc # Calculator
  ];

in
{
  # Enable the X11 windowing system
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # GNOME configuration
  services.xserver.displayManager.gdm.enable = (desktopEnvironment == "gnome");
  services.xserver.desktopManager.gnome.enable = (desktopEnvironment == "gnome");

  # GNOME settings and tweaks
  # programs.dconf.enable = (desktopEnvironment == "gnome");
  # Disable GNOME tour
  services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
    [org.gnome.shell]
    welcome-dialog-last-shown-version='9999999999'
    [org.gnome.desktop.interface]
    cursor-theme='Bibata-Original-Classic'
  '';

  # KDE configuration
  services.displayManager.sddm.enable = (desktopEnvironment == "kde");
  services.desktopManager.plasma6.enable = (desktopEnvironment == "kde");

  # Install selected applications based on desktop environment
  environment.systemPackages = 
    (if desktopEnvironment == "gnome" then gnomeApps else []) ++
    (if desktopEnvironment == "kde" then kdeApps else []);

  # Set Bibata cursor as default system-wide
  environment.etc."gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-cursor-theme-name=Bibata-Original-Classic
  '';

  # Set cursor theme for SDDM (KDE)
  services.displayManager.sddm.settings = {
    Theme = {
      CursorTheme = "Bibata-Original-Classic";
    };
  };

  # Set cursor theme for X11
  services.xserver.displayManager.sessionCommands = ''
    ${pkgs.xorg.xsetroot}/bin/xsetroot -xcf ${pkgs.bibata-cursors}/share/icons/Bibata-Original-Classic/cursors/left_ptr 24
  '';

  # Desktop environment customizations
  programs = {
    # File browser integrations
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    
    # Enable app menu integration
    kdeconnect.enable = (desktopEnvironment == "kde");
  };
  
  # Enable automatic login for the user
  services.displayManager.autoLogin = {
    enable = false;
    user = "rahul";
  };

  # If using Wayland, add these settings
  environment.sessionVariables = {
    # For Electron apps to use Wayland
    NIXOS_OZONE_WL = "1";
    # Set cursor theme for Wayland
    XCURSOR_THEME = "Bibata-Original-Classic";
    XCURSOR_SIZE = "24";
  };
}
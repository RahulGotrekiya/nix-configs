# Hyprland window manager configuration for system level
{ config, pkgs, ... }:

{
  # Enable Hyprland Window Manager
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Install required system packages for Hyprland
  environment.systemPackages = with pkgs; [
    # Notification daemon
    mako
    
    # Application launcher
    rofi-wayland
    
    # Status bar
    waybar

    # Wallpaper
    hyprpaper

    # Idle management
    swayidle
    swaylock-effects
    
    # Screen sharing and recording
    pipewire
    wireplumber

    # Polkit authentication agent
    polkit_gnome
  ];

  # Required for screen sharing and audio
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # XDG Portal for screen sharing
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
    wlr.enable = true;
  };

  # Set environment variables for Wayland
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    GDK_BACKEND = "wayland,x11";
  };

  # Auto-start Polkit agent
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
}
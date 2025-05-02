# Configuration for Hyprland in Home Manager

{ config, lib, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;  # Enable Xwayland

    settings = {
      # Monitor configuration
      monitor = ",1920x1080@144,auto,1";
      
      # Input configuration
      input = {
        kb_layout = "us";
        numlock_by_default = true;
        follow_mouse = 1;
        
        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
        };
        
        sensitivity = 0.2; # -1.0 - 1.0, 0 means no modification.
      };
      
      # General configuration
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 0;
        "col.active_border" = "rgba(ca9ee6ff) rgba(f2d5cfff) 45deg";
        "col.inactive_border" = "rgba(b4befecc) rgba(6c7086cc) 45deg";
        layout = "dwindle";
        resize_on_border = true;
      };
      
      # Group configuration
      group = {
        "col.border_active" = "rgba(ca9ee6ff) rgba(f2d5cfff) 45deg";
        "col.border_inactive" = "rgba(b4befecc) rgba(6c7086cc) 45deg";
        "col.border_locked_active" = "rgba(ca9ee6ff) rgba(f2d5cfff) 45deg";
        "col.border_locked_inactive" = "rgba(b4befecc) rgba(6c7086cc) 45deg";
      };
      
      # Decoration configuration
      decoration = {
        rounding = 5;
        
        blur = {
          enabled = true;
          size = 3;
          passes = 4;
          new_optimizations = true;
          ignore_opacity = false;
          xray = false;
        };
        
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
      };
      
      # Dwindle layout configuration
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      
      # Gesture configuration
      gestures = {
        workspace_swipe = true;
      };
      
      # Misc configuration
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };      
    };
  };
}
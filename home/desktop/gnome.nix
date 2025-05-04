{ config, pkgs, ... }:

let
  gnomePackages = with pkgs; [
    gnome-tweaks
    gnome-extension-manager
    adwaita-icon-theme
  ];

  gnomeExtensions = with pkgs.gnomeExtensions; [
    blur-my-shell
  ];
in
{
  home.packages = gnomePackages ++ gnomeExtensions;

  # Add environment variables to enforce dark theme
  home.sessionVariables = {
    GTK_THEME = "Adwaita:dark";
    # Force Electron/Chromium apps to use dark mode
    FORCE_DARK_MODE = "1";
    # Force QT apps to match GTK theme
    QT_QPA_PLATFORMTHEME = "gtk3";
  };

  dconf = {
    enable = true;
    settings = {
      # Custom keybindings
      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
        ];
      };

      # File explorer shortcut (nautilus)
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Super>e";
        command = "nautilus";
        name = "Open File Explorer";
      };

      # Logout shortcut
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
        binding = "<Super><Shift>Delete";
        command = "gnome-session-quit --logout";
        name = "Logout Dialog";
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
        name = "Launch Alacritty";
        command = "alacritty";
        binding = "<Super>Return";
      };

      # Workspace navigation
      "org/gnome/desktop/wm/keybindings" = {
        # Switch to next/previous workspace (similar to workspace e+1/e-1)
        switch-to-workspace-right = ["<Super>f"];
        switch-to-workspace-left = ["<Super>s"];
        
        # Toggle fullscreen (similar to hyprland's fullscreen)
        toggle-fullscreen = ["<Super>d"];
        
        # Kill active window (Wayland compatible way)
        close = ["<Super>q"];
        
        # Move windows to specific workspaces
        move-to-workspace-1 = ["<Super><Shift>1"];
        move-to-workspace-2 = ["<Super><Shift>2"];
        move-to-workspace-3 = ["<Super><Shift>3"];
        move-to-workspace-4 = ["<Super><Shift>4"];
        move-to-workspace-5 = ["<Super><Shift>5"];
        move-to-workspace-6 = ["<Super><Shift>6"];
        move-to-workspace-7 = ["<Super><Shift>7"];
        move-to-workspace-8 = ["<Super><Shift>8"];
        move-to-workspace-9 = ["<Super><Shift>9"];
        move-to-workspace-10 = ["<Super><Shift>0"];
      };

      # Additional window management settings
      "org/gnome/desktop/wm/preferences" = {
        focus-mode = "sloppy";
        raise-on-focus = false;
        button-layout = "appmenu,close:";
      };

      # Mutter settings (including centering new windows)
      "org/gnome/mutter" = {
        center-new-windows = true;
        dynamic-workspaces = true;
        edge-tiling = true;
      };
      
      # Enable Wayland-specific settings
      "org/gnome/mutter/wayland/keybindings" = {
        # Add any Wayland-specific keybindings here if needed
      };

      "org/gnome/desktop/background" = {
        picture-uri = "file://${config.home.homeDirectory}/dotfiles/home/themes/wallpapers/wall.jpg";
        picture-uri-dark = "file://${config.home.homeDirectory}/dotfiles/home/themes/wallpapers/wall.jpg";
      };
      "org/gnome/desktop/screensaver" = {
        picture-uri = "file://${config.home.homeDirectory}/dotfiles/home/themes/wallpapers/wall.jpg";
        primary-color = "#ff7800";
        secondary-color = "#000000";
      };

      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        gtk-theme = "Adwaita-dark";
        icon-theme = "Adwaita";
        cursor-theme = "Bibata-Original-Classic";
      };

      "org/gnome/shell/extensions/user-theme" = {
        name = "Adwaita-dark"; 
      };
      
      # Enable Num Lock on boot
      "org/gnome/settings-daemon/peripherals/keyboard" = {
        numlock-state = "on";
      };
      
      "org/gnome/shell" = {
        favorite-apps = [ 
          "firefox.desktop"
          "Alacritty.desktop"
          "codium.desktop"
          "nautilus.desktop"
          "obsidian.desktop"
        ];
      };
    };
  };
}

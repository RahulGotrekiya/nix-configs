{ libs, config, pkgs, ... }:

{ 
  gtk = {
    enable = true;
    font.name = "Inter";
    font.size = 11;
    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3-dark";
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };

  fonts = {
    fontconfig = { 
      enable = true;
      defaultFonts = {
        serif = [ "Inter" ];
        sansSerif = [ "Inter" ];
        monospace = [ "JetBrainsMono Nerd Font" ];
      };
    };
  };

  # Add environment variables to enforce dark theme
  home.sessionVariables = {
    GTK_THEME = "Adwaita:dark";
    # Force Electron/Chromium apps to use dark mode
    FORCE_DARK_MODE = "1";
  };
}
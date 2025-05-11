{
  pkgs,
  config,
  lib,
  ...
}: {
  services.mako = {
    enable = false;
    font = "JetBrainsMono Nerd Font Regular 13";
    format = "<b>%a</b> <span color=\"#FF6AC1\">󰩃</span> \\n%s\\n%b";
    sort = "-time";
    output = "DP-2";
    layer = "overlay";
    anchor = "top-right";
    backgroundColor = "#1a1b26";
    textColor = "#c0caf5";
    width = 400;
    height = 150;
    margin = "15";
    padding = "15";
    borderSize = 2;
    borderColor = "#bb9af7";
    borderRadius = 3;
    icons = true;
    maxIconSize = 64;
    defaultTimeout = 6000;
    ignoreTimeout = true;
    extraConfig = ''
      on-notify=exec canberra-gtk-play -i message

      [urgency=normal]
      border-color=#bb9af7

      [urgency=high]
      border-color=#f7768e
      default-timeout=0

      [app-name=lightcord]
      border-color=#7dcfff

      [summary~="log-.*"]
      border-color=#e0af68

      [app-name=lightcord summary~="(.*(^| )orz|ORZ|sto|STO|otl|OTL( |$).*)"]
      invisible=1
    '';
  };

  # Make sure we have the required dependencies
  home.packages = with pkgs; [
    libcanberra-gtk3  # For the canberra-gtk-play sound notification
  ];
}

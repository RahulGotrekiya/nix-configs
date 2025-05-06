{
  pkgs,
  config,
  lib,
  ...
}: 

{
  services.swaync = {
    enable = true;
    
    # Configure settings
    settings = {
      # General notification settings
      "$schema" = "${pkgs.swaynotificationcenter}/etc/xdg/swaync/configSchema.json";
      positionX = "right";
      positionY = "top";
      layer = "overlay";
      control-center-layer = "top";
      control-center-margin-top = 0;
      control-center-margin-bottom = 0;
      control-center-margin-right = 0;
      control-center-margin-left = 0;
      notification-icon-size = 64;
      notification-body-image-height = 100;
      notification-body-image-width = 200;
      timeout = 10;
      timeout-low = 5;
      timeout-critical = 0;
      notification-window-width = 400;
      keyboard-shortcuts = true;
      image-visibility = "when-available";
      transition-time = 200;
      hide-on-clear = true;
      hide-on-action = true;
      script-fail-notify = true;
      scripts = { };
      notification-visibility = {
        "spotify" = {
          state = "enabled";
          app-name = "Spotify";
        };
      };
      
      # Widget configs
      widgets = [
        {
          type = "menubar";
          name = "control-center-menubar";
          height = 40;
          "icon-size" = 18;
          buttons = [
            {
              type = "toggle";
              name = "dnd";
              text = "Do Not Disturb";
              label = "toggle-dnd";
              command = "${pkgs.swaynotificationcenter}/bin/swaync-client -t -sw";
              icon = "bell";
            }
            {
              type = "toggle";
              name = "inhibitor";
              text = "Inhibit Notifications";
              label = "inhibitor";
              command = "inhibitor";
              icon = "bell-cancel";
            }
            {
              type = "shortcut";
              name = "clear-all";
              text = "Clear All";
              label = "clear-all";
              command = "${pkgs.swaynotificationcenter}/bin/swaync-client -C -sw";
              icon = "clear-all";
            }
          ];
        }
        {
          type = "dnd";
          name = "dnd-widget";
          text = "Do Not Disturb";
          executive-command = {
            enable = "${pkgs.swaynotificationcenter}/bin/swaync-client --inhibitor-add dnd-widget";
            disable = "${pkgs.swaynotificationcenter}/bin/swaync-client --inhibitor-remove dnd-widget";
          };
        }
        {
          type = "mpris";
          name = "mpris";
          player = "";
          title-len = 60;
          button-icons = {
            play = "play";
            pause = "pause";
            next = "next";
            prev = "prev";
          };
        }
        {
          type = "backlight";
          name = "brightness";
          device = "";
          title = "Brightness";
          icon-size = 24;
          icon = "display-brightness-symbolic";
          percentage-change = 5;
        }
        {
          type = "volume";
          name = "volume";
          title = "Volume";
          icon-size = 24;
          icon = "audio-volume-high-symbolic";
          percentage-change = 5;
        }
      ];
    };
    
    # Style configuration (similar to Mako theme)
    style = ''
      /* General styling */
      * {
        font-family: "Bricolage Grotesque";
        font-size: 18px;
      }

      .control-center {
        background-color: #1a1b26;
        border-radius: 3px;
        border: 2px solid #bb9af7;
        color: #c0caf5;
        margin: 15px;
      }

      .notification-row {
        outline: none;
        margin: 15px;
        padding: 15px;
      }

      .notification {
        background-color: #1a1b26;
        border-radius: 3px;
        border: 2px solid #bb9af7;
        margin: 0px;
        box-shadow: 0 0 8px 0 rgba(0, 0, 0, 0.5);
      }

      .notification-content {
        padding: 10px;
        margin: 0px;
      }

      .notification-default-action,
      .notification-action {
        margin: 2px;
        padding: 4px;
        border-radius: 3px;
      }

      .notification-default-action:hover,
      .notification-action:hover {
        background-color: rgba(255, 255, 255, 0.1);
      }

      .notification-default-action {
        border-radius: 3px;
      }

      .notification-default-action:not(:only-child) {
        border-bottom-left-radius: 0px;
        border-bottom-right-radius: 0px;
      }

      .notification-action {
        border-radius: 3px;
        border-top-width: 0px;
        border-right-width: 0px;
        border-bottom-width: 0px;
        border-left-width: 0px;
      }

      .notification-action:first-child {
        border-bottom-left-radius: 0px;
        border-bottom-right-radius: 0px;
        border-top-right-radius: 0px;
        border-top-left-radius: 0px;
      }

      .notification-action:last-child {
        border-top-left-radius: 0px;
        border-top-right-radius: 0px;
        border-bottom-left-radius: 3px;
        border-bottom-right-radius: 3px;
      }

      .image {
        margin-right: 15px;
      }

      .body-image {
        margin-top: 10px;
        background-color: #1a1b26;
        border-radius: 3px;
      }

      .summary {
        font-size: 16px;
        font-weight: bold;
        color: #c0caf5;
        margin: 0px;
      }

      .time {
        font-size: 14px;
        font-weight: normal;
        color: #7aa2f7;
        margin: 0px;
      }

      .body {
        font-size: 15px;
        font-weight: normal;
        color: #a9b1d6;
        margin: 10px 0px 0px;
      }

      /* Urgent notification styling */
      .urgent {
        border: 2px solid #f7768e;
      }

      /* Notifications with app-name=lightcord */
      .notification.lightcord {
        border-color: #7dcfff;
      }

      /* Specific toggle button styling */
      .dnd-button {
        background-color: #1a1b26; 
        border: 2px solid #bb9af7;
        padding: 8px;
        margin: 4px;
        border-radius: 3px;
      }

      .dnd-button:hover {
        background-color: #24283b;
      }

      .dnd-button.active {
        background-color: #bb9af7;
        color: #1a1b26;
      }

      /* Control center buttons */
      .control-center-menubar button {
        border: none;
        background: none;
        color: #c0caf5;
        padding: 8px;
        margin: 4px;
        border-radius: 3px;
      }

      .control-center-menubar button:hover {
        background-color: #24283b;
      }

      /* MPRIS widget styling */
      .mpris {
        background-color: #24283b;
        padding: 10px;
        margin: 10px;
        border-radius: 3px;
      }
      
      .mpris button {
        background-color: #1a1b26;
        border: none;
        padding: 8px;
        margin: 4px;
        border-radius: 3px;
      }

      .mpris button:hover {
        background-color: #414868;
      }

      /* Volume and brightness sliders */
      .volume, .brightness {
        padding: 10px;
        margin: 10px;
        background-color: #24283b;
        border-radius: 3px;
      }

      scale trough {
        background-color: #1a1b26;
        border-radius: 3px;
        min-height: 10px;
      }

      scale trough highlight {
        background-color: #bb9af7;
        border-radius: 3px;
      }
    '';
  };

  # Add necessary packages
  home.packages = with pkgs; [
    swaynotificationcenter
    libcanberra-gtk3  # For sound notifications
  ];
}

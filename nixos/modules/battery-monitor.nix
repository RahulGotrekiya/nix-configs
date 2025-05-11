{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.services.battery-monitor;
in {
  options.services.battery-monitor = {
    enable = mkEnableOption "Battery level monitoring service";
    
    normalLevels = mkOption {
      type = types.listOf types.int;
      default = [ 30 20 15 ];
      description = "Battery levels at which to show normal notifications";
    };
    
    criticalLevel = mkOption {
      type = types.int;
      default = 10;
      description = "Battery level below which to show continuous critical notifications";
    };
    
    criticalIntervalSeconds = mkOption {
      type = types.int;
      default = 1;
      description = "Interval between critical notifications in seconds";
    };
    
    hibernateLevel = mkOption {
      type = types.nullOr types.int;
      default = 5;
      description = "Battery level at which to hibernate the system (null to disable)";
    };
    
    chargerNotifications = mkOption {
      type = types.bool;
      default = true;
      description = "Enable notifications when charger is connected or disconnected";
    };
  };

  config = mkIf cfg.enable {
    # Ensure power management and notification services are enabled
    services.upower.enable = true;
    
    # Create battery monitoring user service
    systemd.user.services.battery-monitor = {
      description = "Battery level monitoring service";
      wantedBy = [ "default.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.writeScript "battery-monitor.sh" ''
          #!${pkgs.bash}/bin/bash
          
          PATH=${lib.makeBinPath (with pkgs; [
            libnotify
            upower
            coreutils
            gnugrep
          ])}
          
          LAST_NOTIFICATION_LEVEL=100
          NORMAL_LEVELS="${concatStringsSep " " (map toString cfg.normalLevels)}"
          CRITICAL_LEVEL=${toString cfg.criticalLevel}
          CRITICAL_INTERVAL=${toString cfg.criticalIntervalSeconds}
          CHARGER_NOTIFICATIONS=${toString (if cfg.chargerNotifications then "true" else "false")}
          
          # Keep track of previous charging state
          PREV_CHARGING_STATE="unknown"
          
          # Function to check if a level is in our normal notification list
          contains_level() {
            for level in $NORMAL_LEVELS; do
              if [ "$level" -eq "$1" ]; then
                return 0
              fi
            done
            return 1
          }
          
          echo "Battery monitoring service started"
          echo "Normal notification levels: $NORMAL_LEVELS"
          echo "Critical level: $CRITICAL_LEVEL"
          echo "Critical notification interval: $CRITICAL_INTERVAL seconds"
          echo "Charger notifications: $CHARGER_NOTIFICATIONS"
          
          while true; do
            # Get battery percentage and state
            BATTERY_INFO=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0)
            BATTERY_PCT=$(echo "$BATTERY_INFO" | grep percentage | grep -o "[0-9]\+" || echo "100")
            
            # Determine charging state
            if echo "$BATTERY_INFO" | grep -q "state: *charging"; then
              CHARGING="charging"
            elif echo "$BATTERY_INFO" | grep -q "state: *fully-charged"; then
              CHARGING="full"
            else
              CHARGING="discharging"
            fi
            
            # Detect charger connection/disconnection
            if [ "$CHARGER_NOTIFICATIONS" = "true" ] && [ "$PREV_CHARGING_STATE" != "unknown" ] && [ "$PREV_CHARGING_STATE" != "$CHARGING" ]; then
              if [ "$CHARGING" = "charging" ]; then
                notify-send -u low "Charger Connected" "Battery is now charging ($BATTERY_PCT%)" -i battery-good-charging
              elif [ "$PREV_CHARGING_STATE" = "charging" ] || [ "$PREV_CHARGING_STATE" = "full" ]; then
                notify-send -u low "Charger Disconnected" "Running on battery power ($BATTERY_PCT%)" -i battery-good
              fi
            fi
            PREV_CHARGING_STATE="$CHARGING"
            
            # Handle battery level notifications
            if [ "$CHARGING" = "discharging" ]; then
              echo "Battery at $BATTERY_PCT%, discharging"
              
              # Critical notifications
              if [ "$BATTERY_PCT" -le "$CRITICAL_LEVEL" ]; then
                notify-send -u critical "Battery Critical!" "Battery level at $BATTERY_PCT%. Connect charger immediately!" -i battery-empty
                sleep "$CRITICAL_INTERVAL"
                continue
              fi
              
              # Normal notifications when crossing thresholds
              for level in $NORMAL_LEVELS; do
                if [ "$BATTERY_PCT" -le "$level" ] && [ "$LAST_NOTIFICATION_LEVEL" -gt "$level" ]; then
                  echo "Triggering notification for level $level"
                  
                  # Determine urgency based on level
                  URGENCY="low"
                  if [ "$level" -le 15 ]; then
                    URGENCY="normal"
                  fi
                  
                  # Determine icon based on level
                  ICON="battery-good"
                  if [ "$level" -le 20 ]; then
                    ICON="battery-low"
                  fi
                  
                  notify-send -u "$URGENCY" "Battery Notice" "Battery level at $BATTERY_PCT%" -i "$ICON"
                  LAST_NOTIFICATION_LEVEL="$BATTERY_PCT"
                  break
                fi
              done
            else
              echo "Battery at $BATTERY_PCT%, $CHARGING"
              # Reset notification level when charging
              LAST_NOTIFICATION_LEVEL=100
            fi
            
            sleep 1  # Check frequently to catch charger connect/disconnect events
          done
        ''}";
        Restart = "always";
      };
    };
    
    # Optional: Configure suspend on critical battery level
    services.logind.extraConfig = mkIf (cfg.hibernateLevel != null) ''
      HandleCriticalPowerLevel=hibernate
      CriticalPowerLevel=${toString cfg.hibernateLevel}
    '';
  };
}
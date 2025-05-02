{ pkgs, ... }:

pkgs.writeShellScript "toggle" ''
  if pgrep -x "waybar" > /dev/null; then
    ${pkgs.procps}/bin/pkill -x waybar
  else
    ${pkgs.waybar}/bin/waybar &
  fi
''
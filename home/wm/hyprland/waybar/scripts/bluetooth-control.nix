{ pkgs, ... }:

pkgs.writeShellScript "bluetooth-control" ''
  if ${pkgs.bluez}/bin/bluetoothctl show | grep -q "Powered: yes"; then
    ${pkgs.bluez}/bin/bluetoothctl power off
  else
    ${pkgs.bluez}/bin/bluetoothctl power on
  fi
''
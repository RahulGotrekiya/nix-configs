{ config, lib, pkgs, ... }:

let
  bluetooth-control = import ./bluetooth-control.nix { inherit pkgs; };
  get_weather = import ./get_weather.nix { inherit pkgs; };
  gpu-temp = import ./gpu-temp.nix { inherit pkgs; };
  gpu-util = import ./gpu-util.nix { inherit pkgs; };
  toggle = import ./toggle.nix { inherit pkgs; };
in
{
  ".config/waybar/scripts/bluetooth-control".source = bluetooth-control;
  ".config/waybar/scripts/get_weather.sh".source = get_weather;
  ".config/waybar/scripts/gpu-temp".source = gpu-temp;
  ".config/waybar/scripts/gpu-util".source = gpu-util;
  ".config/waybar/scripts/toggle".source = toggle;
}
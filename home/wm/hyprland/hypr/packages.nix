{ config, pkgs, ... }:

{
  # Install required packages
  home.packages = with pkgs; [
    kitty
    alacritty
    nautilus
    waybar
    wl-clipboard
    cliphist
    hyprpaper
    pyprland
    hyprpicker
    rofi-wayland
    brightnessctl
    pulseaudio # For pactl
    playerctl
    libnotify
    swaynotificationcenter
  ];
}
{ config, pkgs, ... }:

{
  services.hyprpaper = {
    enable = true;
    settings = {
      splash_offset = 2.0;
      splash = false;
      preload = [
        "/home/rahul/Downloads/wallpaper.jpg"
      ];

      wallpaper = [
        ",/home/rahul/Downloads/wallpaper.jpg"
      ];
    };
  };
}
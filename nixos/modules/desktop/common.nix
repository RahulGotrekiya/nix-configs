{ pkgs, ... }:

{
  services.xserver.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  environment.etc."gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-cursor-theme-name=Bibata-Original-Classic
  '';

  services.xserver.displayManager.sessionCommands = ''
    ${pkgs.xorg.xsetroot}/bin/xsetroot -xcf ${pkgs.bibata-cursors}/share/icons/Bibata-Original-Classic/cursors/left_ptr 24
  '';

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    XCURSOR_THEME = "Bibata-Original-Classic";
    XCURSOR_SIZE = "24";
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}

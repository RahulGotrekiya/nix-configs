{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    neovim
    git
    fastfetch
    btop
    tree
    spice-vdagent
    spice-gtk
    vscodium
  ];

  # Install firefox.
  programs.firefox.enable = true;
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}

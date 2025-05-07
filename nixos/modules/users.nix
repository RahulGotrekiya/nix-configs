{ config, pkgs, ... }:

{
  # Shell configuration
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
  
  # Define user accounts
  users.users.rahul = {
    isNormalUser = true;
    description = "Rahul Gotrekiya";
    extraGroups = [ 
      "networkmanager"
      "wheel"
      "docker"
      "input"     # Add input group for Kanata
      "uinput"    # Add uinput group for Kanata
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      # thunderbird
    ];
  };
}

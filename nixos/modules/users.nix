{ config, pkgs, ... }:

{
  # Define user accounts
  users.users.rahul = {
    isNormalUser = true;
    description = "Rahul Gotrekiya";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      # thunderbird
    ];
  };

  # Shell configuration
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  # Enable automatic login for the user.
# services.displayManager.autoLogin.enable = true;
# services.displayManager.autoLogin.user = "rahul";
}

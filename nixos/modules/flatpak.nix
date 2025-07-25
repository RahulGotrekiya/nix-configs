{ config, pkgs, ... }:

# let
#   grep = pkgs.gnugrep;
#   desiredFlatpaks = [
#     "org.videolan.VLC"
#     "app.zen_browser.zen"
#     "org.jellyfin.JellyfinServer"
#   ];
# in {
  services.flatpak.enable = true;
  
  # system.userActivationScripts.flatpakManagement = {
  #   text = ''
  #     ${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists flathub \
  #       https://flathub.org/repo/flathub.flatpakrepo

  #     installedFlatpaks=$(${pkgs.flatpak}/bin/flatpak list --app --columns=application)

  #     for installed in $installedFlatpaks; do
  #       if ! echo ${toString desiredFlatpaks} | ${grep}/bin/grep -q $installed; then
  #         echo "Removing $installed because it's not in the desiredFlatpaks list."
  #         ${pkgs.flatpak}/bin/flatpak uninstall -y --noninteractive $installed
  #       fi
  #     done

  #     for app in ${toString desiredFlatpaks}; do
  #       echo "Ensuring $app is installed."
  #       ${pkgs.flatpak}/bin/flatpak install -y flathub $app
  #     done

  #     # Remove unused Flatpaks
  #     ${pkgs.flatpak}/bin/flatpak uninstall --unused -y

  #     # Update all installed Flatpaks
  #     ${pkgs.flatpak}/bin/flatpak update -y
  #   '';
  # };
}
{ config, lib, pkgs, ... }:

{
  fileSystems."/mnt/work" = {
    device = "/dev/disk/by-uuid/8246945646944D33";
    fsType = "ntfs";
    options = [ "defaults" "nofail" ];
  };
  
  # Also ensure the mount point exists
  systemd.tmpfiles.rules = [
    "d /mnt/work 0755 root root -"
  ];
}
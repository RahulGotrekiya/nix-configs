{ config, pkgs, ... }:

{
  networking.firewall.allowedTCPPorts = [ 80 443 ];  # Allow HTTP/HTTPS

  services.httpd = {
    enable = true;
    enablePHP = true;
    phpPackage = pkgs.php83;  # ⬅️ Set PHP version explicitly (php83 is stable and latest supported by phpMyAdmin)
    extraModules = [ "alias" ];

    virtualHosts."localhost" = {
      documentRoot = "/mnt/work/study/Projects/php-root";
    };

    extraConfig = ''
      DirectoryIndex index.php index.html

      <Directory "/mnt/work/study/Projects/php-root">
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
      </Directory>

      Alias /phpmyadmin "/var/www/php-projects/phpmyadmin"
      <Directory "/var/www/php-projects/phpmyadmin">
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
      </Directory>
    '';
  };

  services.mysql.enable = true;
  services.mysql.package = pkgs.mariadb;

  environment.systemPackages = with pkgs; [ php ];
}

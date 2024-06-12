{
  virtualisation.oci-containers.containers = {
    mysql = {
      image = "lscr.io/linuxserver/mariadb";
      environmentFiles = [ /home/markus/mysql.env ];
      volumes = [ "/srv/bookstack/mysql_data:/config" ];
      extraOptions = [ "--network=pers-h" ];
    };
  };
}

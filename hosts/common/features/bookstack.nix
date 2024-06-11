{
  virtualisation.oci-containers.containers = {
    bookstack = {
      image = "lscr.io/linuxserver/bookstack";
      volumes = [ "/srv/bookstack/bookstack_app_data:/config" ];
      environmentFiles = [ /home/markus/bookstack.env ];
      ports = [ "6875:80" ];
      dependsOn = [ "bookstack_db" ];
      extraOptions = [ "--network=pers-h" ];
    };
    bookstack_db = {
      image = "lscr.io/linuxserver/mariadb";
      environmentFiles = [ /home/markus/mysql.env ];
      volumes = [ "/srv/bookstack/bookstack_db_data:/config" ];
      extraOptions = [ "--network=pers-h" ];
    };
  };
}

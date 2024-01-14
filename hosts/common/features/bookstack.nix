{
  virtualisation.oci-containers.containers = {
    bookstack = {
      image = "lscr.io/linuxserver/bookstack";
      environment = {
        PUID = 1000;
        PGID = 1000;
        APP_URL = "https://bookstack.nyma.cc";
        DB_HOST = "bookstack_db";
        DB_PORT = 3306;
        DB_USER = "bookstack";
        DB_PASS = "pw123";
        DB_DATABASE = "bookstackapp";
      };
      volumes = [ "/srv/bookstack/bookstack_app_data:/config" ];
      ports = [ "6875:80" ];
      dependsOn = [ "bookstack_db" ];
    };
    bookstack_db = {
      image = "lscr.io/linuxserver/mariadb";
      environment = {
        PUID = 1000;
        PGID = 1000;
        MYSQL_ROOT_PASSWORD = "pw123";
        TZ = "Europe/Helsinki";
        MYSQL_DATABASE = "bookstackapp";
        MYSQL_USER = "bookstack";
        MYSQL_PASSWORD = "pw123";
      };
      volumes = [ "/srv/bookstack/bookstack_db_data:/config" ];
    };
  };
}

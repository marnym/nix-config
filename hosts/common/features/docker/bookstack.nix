{
  imports = [ ./mysql.nix ];

  virtualisation.oci-containers.containers = {
    bookstack = {
      image = "lscr.io/linuxserver/bookstack";
      volumes = [ "/srv/bookstack/bookstack_app_data:/config" ];
      environmentFiles = [ /home/markus/bookstack.env ];
      ports = [ "6875:80" ];
      dependsOn = [ "mysql" ];
      extraOptions = [ "--network=pers-h" ];
    };
  };
}

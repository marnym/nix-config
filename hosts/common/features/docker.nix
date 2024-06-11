{ pkgs-unstable, ... }: {
  virtualisation.oci-containers.backend = "docker";
  virtualisation.docker = {
    enable = true;
    package = pkgs-unstable.docker_26;
  };
}

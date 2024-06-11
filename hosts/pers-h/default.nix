{ pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../common/global
    ../common/features/docker.nix
    ../common/features/openssh.nix

    ../common/features/bookstack.nix
  ];

  networking.hostName = "pers-h";

  users.users.markus = {
    hashedPassword = "$6$ZMgx0BL66B2P5k4o$6qHzWuZCkuth52VMmcm4D1OVpMavvSJOXwUFw7jpwplcxDRDTakPnfWlWnPCvOFphQhRITJqF169HxfKHbbl4/";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAYrteSUBgXlSPuZagjKFJQcfWhS10wQrJo3pVZtlm1P markus"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPrndQoxNh1dr9O9yuBG6NiQvOgWCcTsk8Wz02N2mhoN markus"
    ];
    packages = [ pkgs.grc ];
  };


  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
  };
}

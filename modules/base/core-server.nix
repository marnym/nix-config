{
  imports = [ ./core.nix ];

  users.users.markus = {
    hashedPassword = "$6$ZMgx0BL66B2P5k4o$6qHzWuZCkuth52VMmcm4D1OVpMavvSJOXwUFw7jpwplcxDRDTakPnfWlWnPCvOFphQhRITJqF169HxfKHbbl4/";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAYrteSUBgXlSPuZagjKFJQcfWhS10wQrJo3pVZtlm1P markus"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPrndQoxNh1dr9O9yuBG6NiQvOgWCcTsk8Wz02N2mhoN markus"
    ];
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
    settings.PermitRootLogin = "no";
  };

  networking.firewall.allowedTCPPorts = [ 22 ];
}

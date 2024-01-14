{
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
    settings.PermitRootLogin = "without-password";
  };

  networking.firewall.allowedTCPPorts = [ 22 ];
}

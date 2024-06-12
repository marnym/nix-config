{ pkgs, private, ... }: {
  environment.systemPackages = [ pkgs.wireguard-tools ];
  networking.firewall = {
    allowedUDPPorts = [ private.wireguard.port ];
  };
}

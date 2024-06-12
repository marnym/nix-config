{ pkgs, private, ... }:
let
  external-interface = "enp1s0";
in
{
  networking.nat = {
    enable = true;
    externalInterface = external-interface;
    internalInterfaces = [ "wg0" ];
  };

  networking.wg-quick.interfaces = {
    wg0 = {
      address = [ private.wireguard.peers.pers-c.ip ];
      listenPort = private.wireguard.port;
      preUp = ''
        ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s ${private.wireguard.subnet} -o ${external-interface} -j MASQUERADE
      '';
      postDown = ''
        ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s ${private.wireguard.subnet} -o ${external-interface} -j MASQUERADE
      '';
      privateKeyFile = "/srv/wireguard-keys/private";

      peers = [
        {
          publicKey = private.wireguard.peers.timred.key;
          allowedIPs = [ private.wireguard.peers.timred.ip ];
        }
        {
          publicKey = private.wireguard.peers.pers-h.key;
          allowedIPs = [ private.wireguard.peers.pers-h.ip ];
        }
        {
          publicKey = private.wireguard.peers.iPhone.key;
          allowedIPs = [ private.wireguard.peers.iPhone.ip ];
        }
      ];
    };
  };
}

{ ... }:

{
  imports = [
    ../configuration.nix
    ../hardware-configuration/koun.nix
  ];

  networking.hostName = "koun";

  services.syncthing.devices = {
    "persC" = { id = "RMIX3JF-FQN5TTD-M62XRKG-SKVKXHJ-7ETUFPN-U4JOEG2-CFLZCSB-F4TXAQ2"; };
    "macOS" = { id = "TA4TOU5-BFEAXWC-2ZIEN6I-G6PZAND-R2ADBUQ-OIDYGKC-NC5E3E6-ZDYOZAB"; };
  };
}

{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../base.nix
  ];

  networking.hostName = "koun";

  services.syncthing = {
    enable = true;
    user = "markus";
    dataDir = "/home/markus";
    configDir = "/home/markus/.config/syncthing";
    overrideDevices = true;
    overrideFolders = true;
    devices = {
      "persC" = { id = "RMIX3JF-FQN5TTD-M62XRKG-SKVKXHJ-7ETUFPN-U4JOEG2-CFLZCSB-F4TXAQ2"; };
      "macOS" = { id = "TA4TOU5-BFEAXWC-2ZIEN6I-G6PZAND-R2ADBUQ-OIDYGKC-NC5E3E6-ZDYOZAB"; };
    };
    folders = {
      "Cloud" = {
        id = "capiu-mnq67";
        label = "Cloud";
        path = "/home/markus/Cloud";
        devices = [ "persC" "macOS" ];
        type = "sendreceive";
      };
    };
  };
}

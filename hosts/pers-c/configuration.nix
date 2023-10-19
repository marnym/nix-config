{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/base/core-server.nix
  ]

    networking.hostName = "pers-h";


  services.syncthing.devices = {
    "koun" = {
      id = "TK7YIDD-JPLACEZ-Q3SQAKJ-2FRW7PI-WZMXHHJ-BCG3YAC-ULV27ZX-K42HQAW";
      addresses = [ "tcp://192.168.0.2:22000" ];
    };
    "macOS" = { id = "TA4TOU5-BFEAXWC-2ZIEN6I-G6PZAND-R2ADBUQ-OIDYGKC-NC5E3E6-ZDYOZAB"; };
  };

  services.syncthing.folders.Cloud.devices = [ "koun" "macOS" ];
}

{ config, ... }:
let
  allDevices = [
    {
      name = "timred";
      value = { id = "TK7YIDD-JPLACEZ-Q3SQAKJ-2FRW7PI-WZMXHHJ-BCG3YAC-ULV27ZX-K42HQAW"; };
    }
    {
      name = "thinkpad";
      value = { id = "L5GYP2W-PLYPCNP-MJCTAI2-VXNOZAS-2MVYSPP-2PHYS55-E5FPCG5-ZP2TQAI"; };
    }
    {
      name = "macOS";
      value = { id = "TA4TOU5-BFEAXWC-2ZIEN6I-G6PZAND-R2ADBUQ-OIDYGKC-NC5E3E6-ZDYOZAB"; };
    }
    {
      name = "pers-h";
      value = { id = "TNSHZQ4-655EX5Y-SOKDHKT-6WRXJ7W-ZNCXJ32-QLG4DXR-K276JSX-SHK5DA5"; };
    }
  ];

  devices = builtins.listToAttrs (builtins.filter (x: x.name != config.networking.hostName) allDevices);
in
{
  services.syncthing = {
    inherit devices;
    enable = true;
    user = "markus";
    dataDir = "/home/markus";
    configDir = "/home/markus/.config/syncthing";
    overrideDevices = true;
    overrideFolders = false;
    folders = {
      Cloud = {
        id = "capiu-mnq67";
        label = "Cloud";
        path = "/home/markus/Cloud";
        type = "sendreceive";
        devices = builtins.attrNames devices;
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 8384 22000 ];
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];
}

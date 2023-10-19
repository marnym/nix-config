{
  services.syncthing = {
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
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 8384 22000 ];
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];
}

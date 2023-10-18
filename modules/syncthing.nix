{
  services.syncthing = {
    enable = true;
    user = "markus";
    dataDir = "/home/markus";
    configDir = "/home/markus/.config/syncthing";
    overrideDevices = true;
    overrideFolders = true;
    folders = {
      Cloud = {
        id = "capiu-mnq67";
        label = "Cloud";
        path = "/home/markus/Cloud";
        type = "sendreceive";
      };
    };
  };
}

{
  services.syncthing = {
    enable = true;
    user = "markus";
    dataDir = "/home/markus";
    configDir = "/home/markus/.config/syncthing";
    openDefaultPorts = true;
  };
}

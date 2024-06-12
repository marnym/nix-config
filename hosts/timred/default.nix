{ inputs, ... }:

{
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd

    ./hardware-configuration.nix

    ../common/global
    ../common/features/docker.nix
    ../common/features/hyprland.nix
    ../common/features/mullvad.nix
    ../common/features/syncthing.nix
    ../common/features/steam.nix
  ];

  hardware.opengl = {
    enable = true;
    driSupport = true;
  };

  networking.hostName = "timred";

  services.udev.extraRules = ''
    # Disable Logitech waking
    ACTION=="add", SUBSYSTEM=="usb", DRIVERS=="usb", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="c548", ATTR{power/wakeup}="disabled"
  '';


  networking.wg-quick.interfaces = {
    wg0 =
      let
        inherit (inputs) private;
        hostConfig = private.wireguard.peers."timred";
      in
      {
        address = [ hostConfig.ip ];
        listenPort = private.wireguard.port;

        privateKeyFile = "/home/markus/wireguard-keys/private";

        peers = [
          {
            publicKey = private.wireguard.peers.pers-c.key;
            allowedIPs = [ "10.100.0.0/24" ];
            endpoint = "${private.wireguard.server}:${toString private.wireguard.port}";
          }
        ];
      };
  };
}

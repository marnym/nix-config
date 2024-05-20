{ pkgs, ... }: {
  home.packages = with pkgs; [
    iotop
    iftop

    strace
    ltrace
    lsof

    # tools
    sysstat
    lm_sensors
    ethtool
    pciutils
    usbutils
  ];
}

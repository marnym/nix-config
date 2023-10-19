{ pkgs, ... }:

{
  imports = [
    ./fish
    ./git.nix
    ./starship.nix
    ./direnv.nix
    ./tmux.nix
    ./ranger
    ./fzf.nix
    ./eza.nix
    ./bat.nix
  ];

  home.packages = with pkgs; [
    # archives    
    zip
    xz
    unzip
    p7zip

    # misc
    neofetch
    grc
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg
    age
    tldr

    # monitoring
    btop
    iotop
    iftop

    strace
    ltrace
    lsof

    # networking
    mtr
    iperf3
    dnsutils
    ldns
    aria2
    socat
    nmap
    ipcalc

    # tools
    sysstat
    lm_sensors
    ethtool
    pciutils
    usbutils

    # utils
    ripgrep
    jq
    yq-go
  ];
}

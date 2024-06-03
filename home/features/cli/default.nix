{ pkgs, ... }:

{
  imports = [
    ./fish
    ./git.nix
    ./starship.nix
    ./direnv.nix
    ./tmux.nix
    ./ranger.nix
    ./yazi.nix
    ./fzf.nix
    ./atuin.nix
    ./eza.nix
    ./bat.nix
    ./btop.nix
  ];

  home.packages = with pkgs; [
    # archives    
    zip
    xz
    unzip
    p7zip

    # misc
    fastfetch
    grc
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    rage
    age-plugin-yubikey
    tldr

    # networking
    mtr
    iperf3
    dnsutils
    ldns
    aria2
    socat
    nmap
    ipcalc

    # utils
    ripgrep
    fd
    jq
    yq-go
    tokei
  ];
}

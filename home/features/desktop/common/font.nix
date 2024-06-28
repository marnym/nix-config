{ pkgs, ... }: {
  home.packages = with pkgs; [
    cascadia-code
    font-awesome
    ibm-plex
    maple-mono-otf
    maple-mono-NF
    noto-fonts
    (nerdfonts.override { fonts = [ "Hack" "IBMPlexMono" "JetBrainsMono" "Noto" ]; })
    iosevka
    helvetica-neue-lt-std
  ];

  fonts.fontconfig.enable = true;
}

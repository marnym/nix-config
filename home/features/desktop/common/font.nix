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
  ];

  fonts.fontconfig.enable = true;
}

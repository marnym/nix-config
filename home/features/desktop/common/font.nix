{ pkgs, ... }: {
  home.packages = with pkgs; [
    cascadia-code
    font-awesome
    ibm-plex
    maple-mono
    maple-mono-NF
    noto-fonts
    (nerdfonts.override { fonts = [ "Hack" "IBMPlexMono" "JetBrainsMono" "Noto" ]; })
  ];

  fonts.fontconfig.enable = true;
}

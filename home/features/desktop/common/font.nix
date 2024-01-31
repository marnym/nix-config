{ pkgs, ... }: {
  home.packages = with pkgs; [
    noto-fonts
    ibm-plex
    cascadia-code
    font-awesome
    (nerdfonts.override { fonts = [ "JetBrainsMono" "IBMPlexMono" "Noto" ]; })
  ];

  fonts.fontconfig.enable = true;
}

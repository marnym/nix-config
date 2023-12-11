{ pkgs, ... }: {
  home.packages = with pkgs; [
    ibm-plex
    (nerdfonts.override { fonts = [ "JetBrainsMono" "IBMPlexMono" ]; })
  ];

  fonts.fontconfig.enable = true;
}

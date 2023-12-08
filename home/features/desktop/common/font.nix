{ pkgs, ... }: {
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" "IBMPlexMono" ]; })
  ];

  fonts.fontconfig.enable = true;
}

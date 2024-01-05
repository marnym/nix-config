{ pkgs, ... }: {
  home.packages = [ pkgs.ghostty ];

  home.file.".config/ghostty/config".source = ./config;
}

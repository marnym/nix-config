{ pkgs, ... }: {
  home.file.".config/mako/config".source = ./config;

  home.packages = [ pkgs.mako ];
}

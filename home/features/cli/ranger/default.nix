{ pkgs, ... }: {
  home.packages = [ pkgs.ranger ];
  home.file.".config/ranger/rc.conf".source = ./rc.conf;
}

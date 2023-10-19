{ pkgs, ... }: {
  home.file.".config/zathura/zathurarc".source = ./zathurarc;
  home.packages = [ pkgs.zathura ];
}

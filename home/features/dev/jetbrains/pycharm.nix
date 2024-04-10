{ pkgs-unstable, ... }: {
  home.packages = [ pkgs-unstable.jetbrains.pycharm-professional ];
  home.file.".ideavimrc".source = ./.ideavimrc;
}

{ pkgs, ... }: {
  home.packages = [ pkgs.unstable.jetbrains.goland ];
  home.file.".ideavimrc".source = ./.ideavimrc;
}

{ pkgs, ... }: {
  home.packages = [ pkgs.unstable.jetbrains.webstorm ];
  home.file.".ideavimrc".source = ./.ideavimrc;
}

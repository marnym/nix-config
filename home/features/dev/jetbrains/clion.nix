{ pkgs, ... }: {
  home.packages = [ pkgs.unstable.jetbrains.clion ];
  home.file.".ideavimrc".source = ./.ideavimrc;
}

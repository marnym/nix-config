{ pkgs, ... }: {
  home.packages = [ pkgs.unstable.jetbrains.rust-rover ];
  home.file.".ideavimrc".source = ./.ideavimrc;
}

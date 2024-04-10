{ pkgs-unstable, ... }: {
  home.packages = [ pkgs-unstable.jetbrains.idea-ultimate ];
  home.file.".ideavimrc".source = ./.ideavimrc;
}

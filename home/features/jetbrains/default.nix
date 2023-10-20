{ pkgs, ... }: {
  home.packages = with pkgs; [
    pkgs.unstable.jetbrains.idea-ultimate
    pkgs.unstable.jetbrains.webstorm
    pkgs.unstable.jetbrains.goland
    pkgs.unstable.jetbrains.pycharm-professional
    pkgs.unstable.jetbrains.clion
    pkgs.unstable.jetbrains.rust-rover
  ];

  home.file.".ideavimrc".source = ./.ideavimrc;
}

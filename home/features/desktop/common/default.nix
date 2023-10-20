{ pkgs, ... }: {
  imports = [
    ./font.nix
    ./firefox.nix
    ./wezterm
    ./jetbrains
  ];

  home.packages = with pkgs; [
    spotify
    telegram-desktop
    obsidian
  ];
}

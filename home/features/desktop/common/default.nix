{ pkgs, ... }: {
  imports = [
    ./font.nix
    ./firefox.nix
    ./wezterm
  ];

  home.packages = with pkgs; [
    spotify
    telegram-desktop
    obsidian
  ];
}

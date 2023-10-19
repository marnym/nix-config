{ pkgs, ... }: {
  imports = [
    ../../modules/hyprland.nix
  ];


  users.users.markus.packages = with pkgs; [
    mako
    xdg-utils
    xfce.thunar
    wl-clipboard
    hyprshot
    chromium
    thunderbird-bin
    wezterm
    zathura
    spotify
    telegram-desktop
    obsidian
    pavucontrol
  ];
}

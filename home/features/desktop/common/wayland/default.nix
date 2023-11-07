{ pkgs, ... }: {
  imports = [
    ./gtk.nix
    ./firefox.nix
    ./gammastep.nix
    ./playerctl.nix
    ./eww
    ./fuzzel
    ./mako
    ./zathura
  ];

  home.packages = with pkgs; [
    xdg-utils
    xfce.thunar
    wl-clipboard
    hyprshot
    thunderbird-bin
    pavucontrol
    discord
    mpv
    spotify
    telegram-desktop
    pkgs.unstable.obsidian
    pkgs.unstable.todoist-electron
  ];
}

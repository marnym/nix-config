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
    wezterm
    xdg-utils
    xfce.thunar
    wl-clipboard
    hyprshot
    chromium
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

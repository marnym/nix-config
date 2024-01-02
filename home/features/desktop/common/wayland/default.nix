{ pkgs, ... }: {
  imports = [
    ./foot
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
    pkgs.unstable.wezterm
    gnome.gnome-terminal
    gnome.nautilus
    xdg-utils
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

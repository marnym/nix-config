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
    ./swayidle.nix
    ./swaylock.nix
  ];

  home.packages = with pkgs; [
    ghostty
    unstable.wezterm
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
    unstable.obsidian
    unstable.todoist-electron
  ];

}

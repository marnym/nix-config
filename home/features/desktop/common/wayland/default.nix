{ pkgs, ... }: {
  imports = [
    ./foot
    ./gtk.nix
    ./hypr
    ./floorp.nix
    ./gammastep.nix
    ./playerctl.nix
    ./waybar
    ./fuzzel
    ./mako
    ./zathura
  ];

  programs.waybar.enable = true;

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
    firefox
    pavucontrol
    discord
    mpv
    sxiv
    spotify
    telegram-desktop
    unstable.obsidian
    unstable.todoist-electron
    wob
  ];

}

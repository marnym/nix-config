{ pkgs, ... }: {
  imports = [
    ./foot
    ./gtk.nix
    ./firefox.nix
    ./librewolf.nix
    ./gammastep.nix
    ./playerctl.nix
    ./waybar
    ./fuzzel
    ./mako
    ./zathura
    ./swayidle.nix
    ./swaylock.nix
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
    pavucontrol
    discord
    mpv
    spotify
    telegram-desktop
    unstable.obsidian
    unstable.todoist-electron
    wob
  ];

}

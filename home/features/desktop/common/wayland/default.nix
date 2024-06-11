{ pkgs, pkgs-unstable, ghostty, hyprshot, ... }: {
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

  programs.waybar = {
    enable = true;
    package = pkgs-unstable.waybar;
  };

  home.packages = with pkgs; [
    ghostty
    pkgs-unstable.wezterm
    gnome.gnome-terminal
    gnome.nautilus
    xdg-utils
    wl-clipboard
    hyprshot
    chromium
    thunderbird-bin
    firefox
    brave
    pavucontrol
    discord
    mpv
    sxiv
    spotify
    telegram-desktop
    pkgs.obsidian
    pkgs.todoist-electron
    wob
    bitwarden
  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = "org.pwmt.zathura-pdf-mupdf.desktop";
      "image/png" = "sxiv.desktop";
      "image/jpeg" = "sxiv.desktop";
    };
  };
}

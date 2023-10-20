{ pkgs, ... }: {
  imports = [
    ./gammastep.nix
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
  ];
}

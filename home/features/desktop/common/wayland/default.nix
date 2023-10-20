{ pkgs, ... }: {
  imports = [
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
  ];
}

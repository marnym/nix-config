{ pkgs, ... }:

{
  imports = [
    ./core.nix
    ../hyprland.nix
  ];

  sound.enable = true;
  hardware.pulseaudio.enable = true;

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

  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };
}

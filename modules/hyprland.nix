{ pkgs, ... }:

{
  environment.pathsToLink = [ "/libexec" ];

  programs.hyprland = {
    enable = true;
    package = pkgs.hyprland-flake;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.unstable.xdg-desktop-portal-gtk ];
  };

  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
  };
}

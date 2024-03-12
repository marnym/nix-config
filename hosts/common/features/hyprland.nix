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
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  systemd.user.targets.graphical-session = {
    unitConfig = {
      RefuseManualStart = false;
      StopWhenUnneeded = false;
    };
  };

  security.pam.services.swaylock = { };

  services.gnome.gnome-keyring.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "gnome3";
  };
}

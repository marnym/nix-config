{ pkgs, ... }: {
  services.swayidle =
    let
      swaylock = "${pkgs.swaylock}/bin/swaylock";
      hyprctl = "${pkgs.hyprland}/bin/hyprctl";
    in
    {
      enable = true;
      events = [
        {
          event = "before-sleep";
          command = "${swaylock} -fF";
        }
      ];
      timeouts = [
        {
          timeout = 10;
          command = "if pgrep swaylock; then hyprctl dispatch dpms off; fi";
          resumeCommand = "${hyprctl} dispatch dpms on";
        }
        {
          timeout = 150;
          command = "${pkgs.swaylock}/bin/swaylock -fF";
        }
        {
          timeout = 200;
          command = "hyprctl dispatch dpms off";
          resumeCommand = "${hyprctl} dispatch dpms on";
        }
        {
          timeout = 300;
          command = "${pkgs.systemd}/bin/systemctl suspend";
        }
      ];
    };
}

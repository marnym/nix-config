{ pkgs, ... }: {
  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock}/bin/swaylock -fF";
      }
    ];
    timeouts = [
      {
        timeout = 180;
        command = "if pgrep swaylock; then hyprctl dispatch dpms off; fi";
        resumeCommand = "hyprctl dispatch dpms on";
      }
      {
        timeout = 300;
        command = "${pkgs.swaylock}/bin/swaylock -fF";
      }
      {
        timeout = 600;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
  };
}

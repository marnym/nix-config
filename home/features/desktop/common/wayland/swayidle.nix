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
        timeout = 10;
        command = "if pgrep swaylock; then hyprctl dispatch dpms off; fi";
        resumeCommand = "hyprctl dispatch dpms on";
      }
      {
        timeout = 300;
        command = "${pkgs.swaylock}/bin/swaylock -fF";
      }
      {
        timeout = 310;
        command = "hyprctl dispatch dpms off";
        resumeCommand = "hyprctl dispatch dpms on";
      }
      {
        timeout = 600;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
  };
}

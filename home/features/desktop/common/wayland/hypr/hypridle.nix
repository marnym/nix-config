{ config, pkgs, lib, hyprland, ... }:
let
  inherit (lib.options) mkOption;

  cfg = config.local.hypridle.timeout;
in

{
  options.local.hypridle.timeout = {
    lock = mkOption {
      type = lib.types.int;
      default = 150;
    };

    screenOff = mkOption {
      type = lib.types.int;
      default = 200;
    };

    suspend = mkOption {
      type = lib.types.int;
      default = 300;
    };
  };

  config = {
    services.hypridle =
      let
        hyprctl = "${hyprland}/bin/hyprctl";
        hyprlock = "${pkgs.hyprlock}/bin/hyprlock";
        pgrep = "${pkgs.procps}/bin/pgrep";
        systemctl = "${pkgs.systemd}/bin/systemctl";
        loginctl = "${pkgs.systemd}/bin/loginctl";
      in
      {
        enable = true;

        settings = {
          general = {
            lockCmd = "${pgrep} hyprlock || ${hyprlock}";
            unlockCmd = "";
            beforeSleepCmd = "${loginctl} lock-session";
            afterSleepCmd = "${hyprctl} dispatch dpms on";
            ignoreDbusInhibit = false;
          };
          listener = [
            {
              timeout = 10;
              onTimeout = "${pgrep} hyprlock && ${hyprctl} dispatch dpms off";
              onResume = "${hyprctl} dispatch dpms on";
            }

            {
              timeout = cfg.lock;
              onTimeout = "${loginctl} lock-session";
              onResume = "";
            }

            {
              timeout = cfg.screenOff;
              onTimeout = "${hyprctl} dispatch dpms off";
              onResume = "${hyprctl} dispatch dpms on";
            }

            {
              timeout = cfg.suspend;
              onTimeout = "${systemctl} suspend";
              onResume = "";
            }
          ];
        };
      };
  };
}

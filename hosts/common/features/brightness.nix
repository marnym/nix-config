{ pkgs, ... }:
let
  brightness = pkgs.writers.writeFishBin "brightness" /* fish */ ''
    set WOBPIPE /tmp/wobpipe
    set AMOUNT 0.05
    set MAX_BRIGHTNESS $(cat /sys/class/backlight/intel_backlight/max_brightness)
    set ACTUAL_BRIGHTNESS $(cat /sys/class/backlight/intel_backlight/actual_brightness)

    set PERCENTAGE $(math "$ACTUAL_BRIGHTNESS / $MAX_BRIGHTNESS")

    # 0.0 <= PERCENTAGE * AMOUNT <= 1.0
    set NEW_PERCENTAGE $(math "min(max(0.0, $PERCENTAGE + $argv[1]), 1.0)")
            math --scale=0 "$NEW_PERCENTAGE * $MAX_BRIGHTNESS" > /sys/class/backlight/intel_backlight/brightness
            math --scale=0 "$NEW_PERCENTAGE * 100" > $WOBPIPE
  '';
in
{
  environment.systemPackages = [ brightness ];

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chgrp video /sys/class/backlight/%k/brightness"
    ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chmod g+w /sys/class/backlight/%k/brightness"
  '';
}

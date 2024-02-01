#! /usr/bin/env fish

set MAX_BRIGHTNESS $(cat /sys/class/backlight/intel_backlight/max_brightness)
set ACTUAL_BRIGHTNESS $(cat /sys/class/backlight/intel_backlight/actual_brightness)

set PERCENTAGE $(math "($ACTUAL_BRIGHTNESS / $MAX_BRIGHTNESS) * 100")


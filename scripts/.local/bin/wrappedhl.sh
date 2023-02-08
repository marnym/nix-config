#!/bin/bash

cd /home/markus/

export GDK_SCALE=1
export _JAVA_AWT_WM_NONREPARENTING=1
export XCURSOR_SIZE=24
export MOZ_ENABLE_WAYLAND=1

exec Hyprland

#!/bin/bash

cd /home/markus/

export GTK_THEME=Catppuccin-Mocha-Standard-Green-Dark
export _JAVA_AWT_WM_NONREPARENTING=1
export XCURSOR_SIZE=24
export MOZ_ENABLE_WAYLAND=1

exec Hyprland

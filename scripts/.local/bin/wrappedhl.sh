#!/bin/bash

cd "$HOME" || (echo "Error: Could not change directory to /home/markus/" && exit 1)

export GTK_THEME=Catppuccin-Mocha-Standard-Sky-dark
export _JAVA_AWT_WM_NONREPARENTING=1
export XCURSOR_SIZE=24

exec Hyprland

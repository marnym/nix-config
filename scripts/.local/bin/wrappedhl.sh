#!/bin/bash

cd "$HOME" || (echo "Error: Could not change directory to /home/markus/" && exit 1)

export GTK_THEME=Qogir-dark
export XCURSOR_SIZE=24

exec Hyprland

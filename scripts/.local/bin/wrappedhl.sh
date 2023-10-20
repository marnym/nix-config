#!/bin/bash

cd "$HOME" || (echo "Error: Could not change directory to /home/markus/" && exit 1)

export WLR_NO_HARDWARE_CURSORS=1
export XCURSOR_SIZE=24

exec Hyprland

#!/bin/bash

cd /home/markus/ || echo "Error: Could not change directory to /home/markus/" && exit 1

env GTK_THEME,Catppuccin-Mocha-Standard-Lavender-Dark
env _JAVA_AWT_WM_NONREPARENTING,1
env XCURSOR_SIZE,24

exec Hyprland

#!/usr/bin/env bash

selected=$(echo -e "lock\nsuspend\nreboot\nshutdown" | fuzzel -d)

case $selected in

    lock)
        swaylock -fF
    ;;

    suspend)
        systemctl suspend
    ;;

    reboot)
        systemctl reboot
    ;;

    shutdown)
        systemctl shutdown
    ;;

esac


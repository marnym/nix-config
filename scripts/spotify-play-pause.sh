#!/bin/bash


if playerctl -p spotify play-pause; then
    exit 0
else
    hyprctl dispatch exec spotify 
    sleep 1
    playerctl -p spotify play-pause
fi

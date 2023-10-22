#!/usr/bin/env bash

windows=$(hyprctl -j clients | jq)

echo "$windows"


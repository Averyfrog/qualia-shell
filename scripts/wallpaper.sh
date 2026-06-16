#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "$0")

echo "The script is located in: $SCRIPT_DIR"

current_wallpaper=$(realpath "$1")

# Get the cursor position
cursor=$(hyprctl cursorpos | tr -d ' ')

# Use awww to set the wallpaper
awww img "$1" --transition-type grow --transition-duration 1.5 --transition-fps 120 --transition-pos 0,0 --invert-y

cp $current_wallpaper $HOME/.cache/current_wallpaper

echo $current_wallpaper > $HOME/Pictures/wallpaper/current

$SCRIPT_DIR/matugen.sh $2 $3

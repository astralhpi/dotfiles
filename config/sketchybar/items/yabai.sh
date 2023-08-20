#!/bin/bash

apps_in_space=(
  icon.width=0
  label.width=0
  script="$PLUGIN_DIR/yabai.sh"
  icon.font="$FONT:Bold:16.0"
  associated_display=active
  icon.color=$WHITE
)

sketchybar --add event window_focus            \
           --add event windows_on_spaces       \
           --add item apps_in_space left               \
           --set apps_in_space "${apps_in_space[@]}"           \
           --subscribe apps_in_space window_focus      \
                             space_change      \
                             windows_on_spaces \
                             mouse.clicked

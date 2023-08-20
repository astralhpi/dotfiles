#!/bin/bash
#

window_state() {
  source "$CONFIG_DIR/colors.sh"
  source "$CONFIG_DIR/icons.sh"

  SPACE=$(yabai -m query --spaces --space)
  SPACE_TYPE=$(echo "$SPACE" | jq -r '.type')

  ICON=""
  LABEL=""

  if [ "$SPACE_TYPE" = "bsp" ]; then
    ICON+=$YABAI_GRID
  elif [ "$SPACE_TYPE" = "stack" ]; then
    ICON+=$YABAI_STACK
    WINDOW=$(yabai -m query --windows --window)
    STACK_INDEX=$(echo "$WINDOW" | jq '.["stack-index"]')
    if [[ $STACK_INDEX -gt 0 ]]; then
      LAST_STACK_INDEX=$(yabai -m query --windows --window stack.last | jq '.["stack-index"]')
      LABEL="$(printf "[%s/%s]" "$STACK_INDEX" "$LAST_STACK_INDEX")"
    fi
  elif [ "$SPACE_TYPE" = "float" ]; then
    ICON+=$YABAI_FLOAT
  fi
 
  args=(--animate sin 10
          --set $NAME)

  [ -z "$LABEL" ] && args+=(label.width=0) \
                  || args+=(label="$LABEL" label.width=50)

  [ -z "$ICON" ] && args+=(icon.width=0) \
                 || args+=(icon="$ICON" icon.width=30)


  sketchybar -m "${args[@]}"

  windows_on_spaces
}

windows_on_spaces () {
  . "$CONFIG_DIR/icon_map_fn.sh"
  CURRENT_SPACES="$(yabai -m query --displays | jq -r '.[].spaces | @sh')"

  args=(--set '/space\..*/' background.drawing=on
        --animate sin 10)

  while read -r line
  do
    for space in $line
    do
      icon_strip=""
      apps=$(yabai -m query --windows --space $space | jq -r ".[].app")
      if [ "$apps" != "" ]; then
        while IFS= read -r app; do
          icon_map "$app"
          icon_strip+="$icon_result "
        done <<< "$apps"
      fi
      drawing="on"
      if [ -z "$icon_strip" ]; then
        drawing="off"
      fi
      args+=(--set space.$space label="$icon_strip" label.drawing="$drawing")
    done
  done <<< "$CURRENT_SPACES"

  sketchybar -m "${args[@]}"
}

mouse_clicked() {
  SPACE=$(yabai -m query --spaces --space)
  SPACE_TYPE=$(echo "$SPACE" | jq -r '.type')

  if [ "$SPACE_TYPE" = "bsp" ]; then
    yabai -m space --layout stack
  elif [ "$SPACE_TYPE" = "stack" ]; then
    yabai -m space --layout float
  elif [ "$SPACE_TYPE" = "float" ]; then
    yabai -m space --layout bsp
  fi
  window_state
}

case "$SENDER" in
  "mouse.clicked") mouse_clicked
  ;;
  "forced") exit 0
  ;;
  "window_focus") window_state 
  ;;
  "windows_on_spaces" | "space_change") windows_on_spaces
  ;;
esac

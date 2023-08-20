#!/usr/bin/env bash

update() {
  LABEL=`yabai -m query --spaces --space $SID | jq -r '.label'`
  LABEL="${LABEL:-$SID}"
  source "$CONFIG_DIR/colors.sh"
  FONT_STYLE=Regular
  BACKGROUND_COLOR=$BACKGROUND_1
  if [ "$SELECTED" = "true" ]; then
    FONT_STYLE=Bold
    BACKGROUND_COLOR=$BACKGROUND_2
  fi
  sketchybar --set $NAME icon.highlight=$SELECTED \
                         label.highlight=$SELECTED \
                         icon.font.style=$FONT_STYLE \
                         background.color=$BACKGROUND_COLOR \
                         icon="$LABEL"
}

mouse_clicked() {
  if [ "$BUTTON" = "right" ]; then
    /usr/local/bin/hs -c "yabaiipc.spaces.remove($SID)"
    (sleep 0.5 && sketchybar --trigger space_change) &
  else
    /usr/local/bin/hs -c "yabaiipc.spaces.focus($SID)"
  fi
}

case "$SENDER" in
  "mouse.clicked") mouse_clicked
  ;;
  *) update
  ;;
esac

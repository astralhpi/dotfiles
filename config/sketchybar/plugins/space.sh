#!/usr/bin/env bash

update() {
  LABEL=`yabai -m query --spaces --space $SID | jq -r '.label' | sed "s/^$/$SID/"`
  echo "Updating space $SID $NAME $SELECTED $LABEL"
  source "$CONFIG_DIR/colors.sh"
  COLOR=$BACKGROUND_2
  FONT_STYLE=Regular
  if [ "$SELECTED" = "true" ]; then
    COLOR=$GREY
    FONT_STYLE=Bold
  fi
  sketchybar --set $NAME icon.highlight=$SELECTED \
                         label.highlight=$SELECTED \
                         icon.font.style=$FONT_STYLE \
                         background.border_color=$COLOR \
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

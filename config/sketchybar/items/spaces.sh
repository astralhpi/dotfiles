#!/usr/bin/env bash

SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12" "13" "14" "15")

sid=0
spaces=()

for i in "${!SPACE_ICONS[@]}"
do
  sid=$((i + 1))
  space=(
    associated_space=$sid
    icon="${SPACE_ICONS[i]}"
    icon.padding_left=10
    icon.padding_right=10
    icon.color=$GREY
    icon.highlight_color=0xFFFFFFFF
    padding_left=2
    padding_right=2
    label.padding_right=20
    label.color=$GREY
    label.highlight_color=$WHITE
    label.y_offset=-1
    label.drawing=off
    background.color=$BACKGROUND_1
    background.border_color=$BACKGROUND_2
    background.drawing=off
    script="$PLUGIN_DIR/space.sh"
  )

  sketchybar --add space space.$sid left    \
             --set space.$sid "${space[@]}" \
             --subscribe space.$sid mouse.clicked
done

spaces_bracket=(
  background.color=$BACKGROUND_1
  background.border_color=$BACKGROUND_2
)

separator=(
  icon=""
  icon.font="$NERD_FONT:Regular:15.0"
  padding_left=10
  padding_right=8
  label.drawing=off
  associated_display=active
  click_script='/usr/local/bin/hs -c "yabaiipc.spaces.new()" && sketchybar --trigger space_change'
  icon.color=$WHITE
)

sketchybar --add bracket spaces_bracket '/space\..*/'  \
           --set spaces_bracket "${spaces_bracket[@]}" \
                                                       \
           --add item separator left                   \
           --set separator "${separator[@]}"

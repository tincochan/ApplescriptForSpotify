#!/bin/bash
#
# To include the line below into your .tmux.conf to see battery % or charging icon.
# set -g status-right "#(/Users/colbyolson/src/scripts/battery.sh) #H %H:%M"

# change color when battery level drops below $warning level
warning=20

ok_color="colour240"
warning_color="colour208"

status=$(pmset -g batt)
percent=$(grep -oE '[0-9]{1,3}%' <<< "$status")

if [[ "${percent//%}" -lt "$warning" ]]
then
    color="#[fg=$warning_color]"
else
    color="#[fg=$ok_color]"
fi

if [[ $status == *Battery*Power* ]]
then
    printf "%s%s%s" "$color" "$percent" "#[default]"
else
    printf "%s%s%s" "$color" "⚡" "#[default]"
fi

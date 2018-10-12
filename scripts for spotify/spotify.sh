#!/bin/bash

# Include the line below into your .tmux.conf to see spotify information
# set -g status-right "#(~/src/scripts/spotify.sh) #H %H:%M"

color="colour240"

if ps aux | grep '/[A]pplications/Spotify.app/Contents/MacOS/Spotify' > /dev/null
then
    artist=$(osascript -e 'tell application "Spotify" to artist of current track as string');
    track=$(osascript -e 'tell application "Spotify" to name of current track as string');
    state=$(osascript -e 'tell application "Spotify" to player state as text')

    if [ "$state" == "paused" ]
    then
        state=" [paused]"
    else
        state=""
    fi

    printf "%s%s%s" "#[fg=$color]" "♫ $artist - $track$state" "#[default]"
else
    return
fi

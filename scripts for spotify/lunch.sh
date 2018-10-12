#!/bin/bash

API_TOKEN=""
API_URL="https://slack.com/api/presence.set"

source /Users/colbyolson/.dotfiles/.conf.d/10-work_related

now "Taking lunch break"

# Set Slack away if running
if pgrep Slack
then
    curl --data "token=${API_TOKEN}&presence=away" ${API_URL}
fi

# Set adium away if running
if pgrep adium
then
osascript <<EOD
    tell application "Adium"
	go away with message "Taking my lunch break."
    end tell
EOD
fi

# Start screensaver
osascript <<EOD
    tell application "System Events"
        start current screen saver
    end tell
EOD

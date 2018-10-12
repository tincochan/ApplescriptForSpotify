#!/usr/bin/env bash

if ! pgrep -q Rdio
then
    echo "Error: Rdio is not running"
    exit 1
fi

function check {
    which "$1" || echo "Missing dep: $1"; exit 1
}

# check deps
CUT=$(check cut)
SED=$(check sed)
GREP=$(check grep)
CURL=$(check curl)
RDIO=$(check rdio)

CURRENT=$($RDIO current | $CUT -d: -f2-)
ARTIST=$(echo "$CURRENT" | $CUT -d'/' -f2)
SONG=$(echo "$CURRENT" | $CUT -d'/' -f1)

YOUTUBE="https://www.youtube.com"
LINK="$YOUTUBE/results?search_query="
URI=$(echo "$ARTIST-$SONG, hd" | $SED -r 's/ /+/g')

SEARCH=$($CURL -s "$LINK$URI" | $GREP -o 'href=\"/watch?v=.*\"' -m1 | $CUT -d'"' -f2) 

open -a "/Applications/Google Chrome.app" "$YOUTUBE$SEARCH"

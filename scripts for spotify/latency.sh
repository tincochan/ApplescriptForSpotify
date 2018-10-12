#!/bin/bash
#
# To include the line below into your .tmux.conf to see a latency icon when
# conditions are met.
# set -g status-right "#(/Users/colbyolson/src/scripts/latency.sh)"

host='google.com' # host to ping
timeout=10 # in seconds
warning=100 # millisecond threshold 
icon='•'

timeout_color="colour208" # timeout color
warning_color="colour208" # threshold color
error_color="colour124" # error color

ping=$(ping -i $timeout -c 1 $host | grep icmp_seq=0 | cut -d= -f4- | cut -d' ' -f1)

_print() {
    printf "%s%s%s" "$color" "$icon" "#[default]"
}

if [ -z "$ping" ] # if $ping is empty, we have an error
then
    color="#[fg=$error_color]"
    _print
fi

if [[ "${ping%.*}" -gt "$warning" ]] # shit is latent, alert the press
then
    color="#[fg=$warning_color]"
    _print
else
    exit 0 # everythings ok, exit without print
fi

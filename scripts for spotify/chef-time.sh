#!/bin/bash

function convertsecs() {
    h=$(($1/3600))
    m=$((($1/60)%60))
    s=$(($1%60))
    printf "02d:%02d:%02d\n $h $m $s"
}

file=~/tmux.history
seconds=""
for time in $(grep 'seconds' $file | cut -d' ' -f7); do
    seconds=$(dc <<<" $time $seconds + p")
done

seconds=$(printf "%.0f" $seconds)
echo $seconds
echo $(convertsecs $seconds)

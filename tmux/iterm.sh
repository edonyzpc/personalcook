#!/bin/sh

tmx_windows=`tmux ls 2>/dev/null | awk -F: '{print $1}'`

if [ "$tmx_windows" == "edony" ]; then
    tmux a -t $tmx_windows
else
    tmuxinator start edony
fi

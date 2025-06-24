#!/bin/bash

# Verify osd_cat exists (only added check)
if ! command -v osd_cat >/dev/null || ! command -v ffmpeg >/dev/null; then
    notify-send "Missing requirements! Install with:
    sudo apt install xosd-bin ffmpeg"
    exit 1
fi

# Check if ffmpeg is running
if pidof ffmpeg >/dev/null; then
    killall ffmpeg
    pkill -f "osd_cat" || true
    notify-send 'Recording Stopped!' --icon=dialog-information
else
    time=$(date +%F-%T | sed 's/-/–/')
    notify-send 'Recording Started!' --icon=dialog-information

    # Get window title and create save folder
    window_title=$(xdotool getwindowfocus getwindowname | tr -d '\n' | tr -d '/')
    folder_name=$(echo "$window_title" | sed 's/ /_/g')
    truncated_folder_name=${folder_name:0:32}
    mkdir -p ~/Videos/"$truncated_folder_name"

    # Your original OSD command (unchanged)
    echo "...." | osd_cat \
        --pos=bottom \
        --align=right \
        --color=lightgrey \
        --shadow=2 \
        --font="-*-helvetica-*-r-*-*-30-*-*-*-*-*-*-*" \
        --delay=-1 &

    # Start recording (original parameters)
    ffmpeg -f x11grab -video_size "$(xdpyinfo | grep dimensions | awk '{print $2}')" -framerate 40 \
           -thread_queue_size 512 -i "$DISPLAY" -f pulse -i default \
           -vcodec libx264 -qp 18 -preset ultrafast \
           ~/Videos/"$truncated_folder_name"/"$truncated_folder_name"-"$time".mp4

    # Cleanup
    pkill -f "osd_cat" || true
fi

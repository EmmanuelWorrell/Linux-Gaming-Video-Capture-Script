#!/bin/bash

# Check if an instance of ffmpeg is running
if pidof ffmpeg; then
    killall ffmpeg
    notify-send 'Stopped Recording!' --icon=dialog-information
else
    time=$(date +%F-%T | sed 's/-/–/')
    notify-send 'Started Recording!' --icon=dialog-information

    # Get the window title
    window_title=$(xdotool getwindowfocus getwindowname | tr -d '\n' | tr -d '/')

    # Replace spaces in the window title with underscores
    folder_name=$(echo "$window_title" | sed 's/ /_/g')

    # Limit the folder name to a maximum of 32 characters
    truncated_folder_name=${folder_name:0:32}

    # Create the folder if it doesn't exist
    mkdir -p ~/Videos/"$truncated_folder_name"

    # Start recording the entire screen and audio using ffmpeg
    ffmpeg -f x11grab -video_size "$(xdpyinfo | grep dimensions | awk '{print $2}')" -framerate 60 \
           -thread_queue_size 1024 -i "$DISPLAY" -f pulse -i default \
           -vcodec libx264 -qp 18 -preset ultrafast \
           ~/Videos/"$truncated_folder_name"/"$truncated_folder_name"-"$time".mp4
fi


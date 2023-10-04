# Linux-Gaming-Video-Capture-Script

This is a simple bash script that is made to help Linux gamers record video of their games without using applications like Steam's launcher.
Its intended to work like Fraps, Geforce Experience or Radeon Adrenalin Software in Windows because there is no Linux equivalent. Assigning this 
script to a hotkey after being triggered will create videos named after the applications window's name and place it in a folder with named 
after the application's windows game limited to 32 characters. So when you record the videos will be organized in a directory named after the game 
with a date time in a folder of the same name.

Also make what ever changes you want to this script any contributions are welcomed and credit me for creating this script.

Requirements: ffmpeg, xdotool

ffmpeg is needed to perform video captures.
ffmpeg can be installed with the following command:
sudo apt-get install ffmpeg

xdotool is needed to get info about opened windows.
xdotool can be installed with the following command:
sudo apt-get install xdotool

The script can be saved in any directory. In your Linux menu search for the application called 'Keyboard' or its equivalent in your distro 
and set up a hotkey for taking screen shots in games. I use 'ctrl' '0' (numpad). The screenshots will be saved in '~/Pictures/Videos/'. 
The videos will be named after the window opened so if you are looking at your desktop that videos folder will be named 'Desktop'.
The script will immediately capture the video with no delay the first hotkey press may need to create the directory first if the directory 
does not exist. Have fun.

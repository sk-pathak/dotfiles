#/bin/sh

timeswaylock=60
timeoff=90

if [ -f "/usr/bin/swayidle" ]; then
	swayidle -w timeout $timeswaylock 'swaylock -f' timeout $timeoff 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on'
else
	echo "swayidle not installed."
fi

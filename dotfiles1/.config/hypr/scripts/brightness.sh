#!/usr/bin/env bash

iDIR="$HOME/.config/mako/icons"

# Get brightness
get_backlight() {
	LIGHT=$(printf "%.0f\n" $(brillo -G))
	echo "${LIGHT}"
}

# Get icons
get_icon() {
	current="$(get_backlight)"
	if [[ ("$current" -ge "-1") && ("$current" -le "21") ]]; then
		icon="$iDIR/brightness-20.png"
	elif [[ ("$current" -ge "21") && ("$current" -le "41") ]]; then
		icon="$iDIR/brightness-40.png"
	elif [[ ("$current" -ge "41") && ("$current" -le "61") ]]; then
		icon="$iDIR/brightness-60.png"
	elif [[ ("$current" -ge "61") && ("$current" -le "81") ]]; then
		icon="$iDIR/brightness-80.png"
	elif [[ ("$current" -ge "81") && ("$current" -le "101") ]]; then
		icon="$iDIR/brightness-100.png"
	fi
}

# Notify
notify_user() {
	notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$icon" "Brightness : $(get_backlight)"
}

# Increase brightness
inc_backlight() {
	brillo -A 5 && get_icon && notify_user
}

# Decrease brightness
dec_backlight() {
	brillo -U 5 && get_icon && notify_user
}

# Execute accordingly
if [[ "$1" == "--get" ]]; then
	get_backlight
elif [[ "$1" == "--inc" ]]; then
	inc_backlight
elif [[ "$1" == "--dec" ]]; then
	dec_backlight
else
	get_backlight
fi

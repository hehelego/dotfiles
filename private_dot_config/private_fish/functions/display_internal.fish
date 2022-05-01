function display_internal
	if test "$XDG_SESSION_TYPE" = "x11"
		xrandr --output eDP \
			--mode 2560x1600 \
			--rate 60 \
			--gamma 1:1:1 \
			--dpi 192 \
			--set TearFree on \
			--orientation normal
		xrandr --output DisplayPort-0 \
			--off
		xrandr --output DisplayPort-1 \
			--off
	end
	if test "$XDG_SESSION_TYPE" = "wayland"
		swaymsg "output eDP-1 \
			enable \
			dpms on \
			mode 2560x1600@60Hz \
			scale 2 \
			scale_filter smart \
			adaptive_sync on \
			"
		swaymsg "output DP-1 \
			disable \
			dpms off \
			"
		swaymsg "output DP-2 \
			disable \
			dpms off \
			"
	end
	setbg
end

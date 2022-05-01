function display_external
	if test "$XDG_SESSION_TYPE" = "x11"
		xrandr --output eDP \
			--off
		xrandr --output DisplayPort-0 \
			--mode 3840x2160 \
			--rate 60 \
			--gamma 1:1:1 \
			--dpi 192 \
			--set TearFree on \
			--orientation normal
			--left-of eDP
		xrandr --output DisplayPort-0 \
			--mode 3840x2160 \
			--rate 60 \
			--gamma 1:1:1 \
			--dpi 192 \
			--set TearFree on \
			--orientation normal
			--right-of eDP
	end
	if test "$XDG_SESSION_TYPE" = "wayland"
		swaymsg "output eDP-1 \
			disable \
			dpms off \
			"
		swaymsg "output DP-1 \
			enable \
			dpms on \
			mode 3840x2160@60Hz \
			scale 2 \
			scale_filter smart \
			adaptive_sync on \
			"
		swaymsg "output DP-2 \
			enable \
			dpms on \
			mode 3840x2160@60Hz \
			scale 2 \
			scale_filter smart \
			adaptive_sync on \
			"
	end
	setbg
end

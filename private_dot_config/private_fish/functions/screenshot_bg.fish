function screenshot_bg
	set path (mktemp)
	if test "$XDG_SESSION_TYPE" = "x11"
		spectacle --background --current --output $path
		feh --bg-fill --no-fehbg $path
	end
	if test "$XDG_SESSION_TYPE" = "wayland"
		grim $path
		swaymsg "output * bg $path fill"
	end
	sleep 1
	rm -f $path
end

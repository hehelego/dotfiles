function setbg
	if test "$XDG_SESSION_TYPE" = "x11"
		set bg_img /usr/share/wallpapers/Opal/contents/images/3840x2160.png
		feh --bg-fill --no-fehbg $bg_img
	end
	if test "$XDG_SESSION_TYPE" = "wayland"
		set bg_img /usr/share/backgrounds/sway/Sway_Wallpaper_Blue_1920x1080.png
		swaymsg "output * bg $bg_img fill"
	end
end

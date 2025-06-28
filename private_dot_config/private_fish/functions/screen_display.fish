function screen_display
	if test (count $argv) -ne 1
		set_color --bold
		echo -n "screen_display: "
		set_color normal
		echo "takes exactly 1 argument (eDP/HDMI)"
		return 1
	end

	switch $argv[1]
		case eDP
			swaymsg output eDP-1    enable  power on resolution 2880x1800 scale 2
			swaymsg output HDMI-A-1 disable power off
		case HDMI
			swaymsg output eDP-1    disable power off
			swaymsg output HDMI-A-1 enable  power on resolution 2560x1440 scale 2
		case '*'
			set_color --bold
			echo -n "screen_display: "
			set_color --bold red
			echo "invalid argument"
	end
end

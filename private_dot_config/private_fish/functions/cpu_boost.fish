function cpu_boost
	if test (count $argv) -ne 1
		set_color --bold
		echo -n "cpu_boost: "
		set_color normal
		echo "takes exactly 1 argument (on/off)"
		return 1
	end

	switch $argv[1]
		case off
			echo 0 | sudo tee /sys/devices/system/cpu/cpufreq/boost
		case on
			echo 1 | sudo tee /sys/devices/system/cpu/cpufreq/boost
		case '*'
			set_color --bold
			echo -n "cpu_boost: "
			set_color --bold red
			echo "invalid argument"
	end
end

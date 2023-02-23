function zathurafzf
	set fzf_sel (fzff)
	if test -n "$fzf_sel"
		zathura $fzf_sel &
		disown $last_pid
	end
end

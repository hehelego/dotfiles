function okularfzf
	set fzf_sel (fzff)
	if test -n "$fzf_sel"
		okular $fzf_sel &
		disown $last_pid
	end
end

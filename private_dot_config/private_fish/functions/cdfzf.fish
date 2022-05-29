function cdfzf
	set fzf_sel (fzfd --no-multi)
	if test -n "$fzf_sel"
		cd $fzf_sel
	end
end

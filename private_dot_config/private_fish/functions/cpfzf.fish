function cpfzf
	set cnt_args (count $argv)
	if test "$cnt_args" -lt "1"
		set_color --bold
		echo -n "cpfzf: "
		set_color normal
		echo "not enough argument"
		return 1
	end

	set dest $argv[1]

	set fzf_sel (fzff)
	for f in $fzf_sel
		cp "$f" "$dest"
	end
end

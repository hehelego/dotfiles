function dict_lookup_sel
  set sel_file "/tmp/selected_text"
  cat /dev/null > $sel_file

  if test "x11" = "$XDG_SESSION_TYPE"
    xclip -o -selection primary > $sel_file
  else if "wayland" = "$XDG_SESSION_TYPE"
    wl-paste --primary > $sel_file
  end

  cat $sel_file | ydcv -n &
	disown $last_pid
end

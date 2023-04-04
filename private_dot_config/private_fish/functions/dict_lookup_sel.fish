function dict_lookup_sel
  set sel_file "/tmp/selected_text"
  cat /dev/null > $sel_file

  if test "x11"     = "$XDG_SESSION_TYPE"
    xclip    -o -selection primary > $sel_file
  else if "wayland" = "$XDG_SESSION_TYPE"
    wl-paste    --primary          > $sel_file
  end


  dict (cat $sel_file) > /tmp/dictd.result 2> /tmp/dictd.error
  if test $status -eq 0
    notify-send "dictd query result" "$(cat /tmp/dictd.result)" &
  else
    notify-send "dictd query error"  "$(cat /tmp/dictd.error)"  &
  end
  disown $last_pid
end

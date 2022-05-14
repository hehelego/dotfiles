function fish_vi_mode_prompt
  switch $fish_bind_mode
    case default
      set_color --bold red
      echo -n 'N'
    case insert
      set_color --bold green
      echo -n 'I'
    case replace_one
      set_color --bold green
      echo -n 'R'
    case visual
      set_color --bold brmagenta
      echo -n 'V'
    case '*'
      set_color --bold red
      echo -n '?'
  end
  set_color normal
end

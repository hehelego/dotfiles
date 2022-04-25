# SECTION: env
#
set -gx TERMINAL alacritty
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx MANPAGER "nvim +Man!"

set -gx LESSHISTFILE "/dev/null"

# SECTION: alias and abbr
#
alias ls="exa"
alias ll="exa --long --group-directories-first"
alias la="exa --long --all --group-directories-first"
alias tree="exa --tree"
alias tree-list="exa --tree --long --all"
alias fzff="fd -HI --type file      --exclude .git | fzf --multi --cycle --preview='stat {}'"
alias fzfd="fd -HI --type directory --exclude .git | fzf --multi --cycle --preview='exa -F1 {}'"
alias bat="bat --pager=less"
alias cat="bat --plain"


# SECTION: zoxide
#
set -gx _ZO_FZF_OPTS "--cycle --preview='exa -F1 {2..}'"
zoxide init fish | source


# SECTION: fzf
#
set -gx FZF_DEFAULT_COMMAND "fd -HI --type file --exclude .git --strip-cwd-prefix"
set -gx FZF_DEFAULT_OPTS "--cycle"


# SECTION: starship
#
if not test "$TERM" = "linux"
  set -gx STARSHIP_CONFIG ~/.config/starship/config.toml
  starship init fish | source
end

# SECTION: key-bindings
fish_hybrid_key_bindings
fzf_key_bindings

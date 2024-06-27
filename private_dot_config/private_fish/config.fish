# SECTION: env
#
set -gx TERMINAL alacritty
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx MANPAGER "nvim +Man!"

# disable less pager history
set -gx LESSHISTFILE /dev/null
# disable node repl history
set -gx NODE_REPL_HISTORY ""
# ocaml library installation path
set -x OCAMLPATH $HOME/.opam/default/lib


# SECTION: alias and abbr
#
alias ls="eza -F              --group-directories-first"
alias ll="eza -F --long       --group-directories-first"
alias la="eza -F --long --all --group-directories-first"
alias lt="eza -F --tree"
alias lta="eza -F --tree --long --all"
alias fdf="fd -HI --type file      --exclude .git --strip-cwd-prefix"
alias fdd="fd -HI --type directory --exclude .git --strip-cwd-prefix"
alias fzff="fdf | fzf --multi --preview='stat {}'"
alias fzfd="fdd | fzf --multi --preview='eza -F -1 --color=always {}'"
alias bat="bat --pager=less"
alias cat="bat --plain"
alias ip="ip -color=auto"


# SECTION: zoxide
#
set -gx _ZO_FZF_OPTS "--cycle --reverse --height=40% --preview='eza -F -1 --color=always {2..}'"
zoxide init fish | source


# SECTION: fzf
#
set -gx FZF_DEFAULT_COMMAND fdf
set -gx FZF_DEFAULT_OPTS "--cycle --reverse --height=40%"


if status is-interactive
    # SECTION: key-bindings
    #
    fish_hybrid_key_bindings
    fzf_key_bindings
end

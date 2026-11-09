alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ll -a'

# The -2 option makes tmux assume the outer shell is 256 color capable
alias tmux='tmux -2'

# The dev service should outlive everything in the user session
alias tmuxd='systemctl --user start --quiet tmux@dev; tmux new -A -s dev'


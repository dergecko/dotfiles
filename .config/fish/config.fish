if status is-interactive
    # Commands to run in interactive sessions can go here
end
set -gx SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket

# Replace standard ls with lsd
alias ls="lsd"

# Optional but highly recommended: replace other common list commands
alias ll="lsd -l"
alias la="lsd -a"
alias lla="lsd -la"
alias lt="lsd --tree"

# Git abbreviations
abbr -a gs "git status"
abbr -a ga "git add"
abbr -a gc "git commit"
abbr -a gp "git push"
abbr -a gr "git rebase"

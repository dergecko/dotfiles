if status is-interactive
    # Commands to run in interactive sessions can go here
    direnv hook fish | source
end

# Only on the host; the dev container forwards its own agent socket
if set -q XDG_RUNTIME_DIR; and test -S $XDG_RUNTIME_DIR/ssh-agent.socket
    set -gx SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket
end

# Nix-provided completions (fish has already read XDG_DATA_DIRS, so add the path directly)
for p in ~/.nix-profile/share /nix/var/nix/profiles/default/share
    if test -d $p/fish/vendor_completions.d
        set -p fish_complete_path $p/fish/vendor_completions.d
    end
end

# Optional: let programs started from this shell find Nix data files too
set -gx XDG_DATA_DIRS ~/.nix-profile/share /nix/var/nix/profiles/default/share $XDG_DATA_DIRS /usr/local/share /usr/share

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

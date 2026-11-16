# The config files are symlinks into the dotfiles repo, and inotify doesn't follow
# symlinks, so watch the directory they point into as well
repo_dir=$(dirname "$(readlink -f ~/.config/waybar/config.jsonc)")
while inotifywait -e close_write ~/.config/waybar "$repo_dir"; do killall -SIGUSR2 waybar; done

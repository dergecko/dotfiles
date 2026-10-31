# Dotfiles

## Tools

- niri: tiling window manager
- waybar: statusbar
- alacritty: terminal
- fish: shell
- fuzzel: app launcher, also used for the clipboard and wifi menus
- swaybg: wallpaper background display
- swaylock: screen locker
- mako: notification daemon (shows desktop notifications)
- cliphist: clipboard history
- wl-clipboard: `wl-copy`/`wl-paste`, feeds cliphist
- xwayland-satellite: runs X11 apps under niri

### Statusbar and hotkeys

- NetworkManager + nm-connection-editor: wifi menu and network settings
- tuned-ppd: power profile switching (power-profiles-daemon API)
- wireplumber: volume keys (`wpctl`)
- pulseaudio-utils: mute on click in waybar (`pactl`)
- playerctl: media keys
- brightnessctl: brightness keys
- libnotify: `notify-send` for wifi connect messages (shown by mako)
- inotify-tools: waybar `auto-reload.sh`

### Fonts

- dejavu-sans-mono-fonts: font for waybar, alacritty and fuzzel
- powerline-fonts: arrows in waybar
- fontawesome-6-free-fonts: icons in waybar

### Install (Fedora)

```sh
sudo dnf install niri waybar alacritty fish fuzzel swaybg swaylock cliphist wl-clipboard xwayland-satellite \
    NetworkManager nm-connection-editor tuned-ppd wireplumber pulseaudio-utils playerctl brightnessctl \
    libnotify mako inotify-tools \
    dejavu-sans-mono-fonts powerline-fonts fontawesome-6-free-fonts
./install.sh
```

## Background

a file at `~/Pictures/wallpaper.jpg` will be loaded as the background image.

> With `magick wallpaper.png wallpaper.jpg` you can convert images (add `-background "#282828" -flatten` for ones with transparancy).

#!/usr/bin/env bash
# Pick a wifi network with fuzzel and connect to it via NetworkManager.
# Known networks reuse their saved profile, new secured ones ask for a password.

set -uo pipefail

notify() { command -v notify-send >/dev/null && notify-send -a "Wi-Fi" "$@"; }

# IN-USE:SIGNAL:SECURITY:SSID, connected network first, then strongest first, one entry per SSID
mapfile -t networks < <(
    nmcli -t -e no -f IN-USE,SIGNAL,SECURITY,SSID dev wifi list --rescan auto |
        sort -t: -k1,1r -k2,2nr |
        awk '{ ssid = $0; sub(/^[^:]*:[^:]*:[^:]*:/, "", ssid) } ssid != "" && !seen[ssid]++'
)

menu=""
for line in "${networks[@]}"; do
    IFS=: read -r inuse signal security ssid <<<"$line"
    lock=" "; [[ -n "$security" && "$security" != "--" ]] && lock=$'\uf023'
    mark=" "; [[ "$inuse" == "*" ]] && mark=$'\uf00c'
    menu+="$mark $lock $(printf '%3s' "$signal")%  $ssid"$'\n'
done

choice=$(printf '%s' "$menu" | fuzzel --dmenu --prompt "Wi-Fi: " --index) || exit 0
IFS=: read -r inuse _ security ssid <<<"${networks[$choice]}"

if [[ "$inuse" == "*" ]]; then
    nmcli connection down id "$ssid" && notify "Disconnected from $ssid"
    exit 0
fi

if nmcli -t -f NAME connection show | grep -Fxq "$ssid"; then
    nmcli connection up id "$ssid" && notify "Connected to $ssid" && exit 0
fi

args=(device wifi connect "$ssid")
if [[ -n "$security" && "$security" != "--" ]]; then
    password=$(fuzzel --dmenu --password --prompt-only "Password for $ssid: ") || exit 0
    args+=(password "$password")
fi

if nmcli "${args[@]}"; then
    notify "Connected to $ssid"
else
    notify -u critical "Failed to connect to $ssid"
fi

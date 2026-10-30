#!/usr/bin/env bash
# Symlink every file under this repo's .config/ into ~/.config/.
# Existing files are moved to <file>.bak.<timestamp> before linking.
# Usage: ./install.sh [--dry-run]

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_DIR="$REPO_DIR/.config"
DEST_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
DRY_RUN=false

[[ "${1:-}" == "--dry-run" ]] && DRY_RUN=true

run() {
    if $DRY_RUN; then
        echo "[dry-run] $*"
    else
        "$@"
    fi
}

while IFS= read -r -d '' src; do
    rel="${src#"$SRC_DIR"/}"
    dest="$DEST_DIR/$rel"

    # Already linked to the right place
    if [[ -L "$dest" && "$(readlink -f "$dest")" == "$src" ]]; then
        echo "ok      $rel"
        continue
    fi

    run mkdir -p "$(dirname "$dest")"

    if [[ -e "$dest" || -L "$dest" ]]; then
        echo "backup  $rel -> $rel.bak.$TIMESTAMP"
        run mv "$dest" "$dest.bak.$TIMESTAMP"
    fi

    echo "link    $rel"
    run ln -s "$src" "$dest"
done < <(find "$SRC_DIR" -type f -print0)

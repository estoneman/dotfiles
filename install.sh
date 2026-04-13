#!/usr/bin/env bash

set -euo pipefail

chk_cmd() {
    # $1 => command to check existence
    command -v "$1" &>/dev/null
}

_CMD_DEPS=(
    fastfetch
    rg
    stow
)

for _CMD in "${_CMD_DEPS[@]}"; do
    if ! chk_cmd "$_CMD"; then
        echo "$_CMD is not installed" >&2
        exit 1
    fi
done

(
    cd ./install
    for _PKG in *; do
        stow -t "$HOME" --no-folding "$_PKG"

        # find broken links and remove them
        linkdir=$(fd -H -d 1 -t d . "$_PKG" -x echo "$HOME/{/}/$_PKG")
        rg --hidden -L --files . $linkdir 2>&1 \
            | awk '/os error/ { print substr($2, 0, length($2)-1) }' \
            | xargs rm -f
    done
)

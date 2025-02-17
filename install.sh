#!/usr/local/bin/bash

set -euo pipefail

if &>/dev/null ! command stow; then
    1>&2 echo -e 'stow is not installed.. exiting'
    exit 1
fi

declare -a _PKGS
_PKGS=(
    bash
    ghostty
    nvim
    tmux
)

for _PKG in "${_PKGS[@]}"; do
    stow -t "$HOME" --no-folding "$_PKG"
done

unset _PKG _PKGS

#!/usr/bin/env bash

set -euo pipefail

if command stow &>/dev/null; then
    echo -e 'stow is not installed.. exiting' 1>&2
    exit 1
fi

declare -a _PKGS
_PKGS=(
    bash
    bat
    ghostty
    nvim
    sqls
    tmux
    tpm
)

for _PKG in "${_PKGS[@]}"; do
    stow -t "$HOME" --no-folding "$_PKG"
done

unset _PKG _PKGS

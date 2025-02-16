#!/usr/local/bin/bash

set -euo pipefail

stow -t "$HOME" --no-folding bash
stow -t "$HOME" --no-folding ghostty
stow -t "$HOME" --no-folding nvim
stow -t "$HOME" --no-folding tmux

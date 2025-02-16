# .bash_profile

declare -x XDG_CONFIG_HOME

(cd "$HOME/dotfiles" && ./install.sh)

XDG_CONFIG_HOME="$HOME/.config"
if [ -f "$XDG_CONFIG_HOME/bash/.bashrc" ] ; then
    # shellcheck disable=SC1091
    . "$XDG_CONFIG_HOME/bash/.bashrc"
fi

# .bash_profile

declare -x XDG_CONFIG_HOME

PATH='/usr/local/bin:/usr/local/sbin:/opt/bin:/usr/bin:/usr/sbin:/bin:/sbin'
(cd "$HOME/dotfiles" && ./install.sh)

XDG_CONFIG_HOME="$HOME/.config"
if [ -f "$XDG_CONFIG_HOME/bash/.bashrc" ] ; then
    # shellcheck disable=SC1091
    . "$XDG_CONFIG_HOME/bash/.bashrc"
fi

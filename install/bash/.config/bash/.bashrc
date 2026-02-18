# .bashrc

_RC_D=$XDG_CONFIG_HOME/bash/.bashrc.d
readarray -t _LOAD_ORDER <<< "$(ls -A "$_RC_D")"

if [ -d "$_RC_D" ]; then
    for _RC in "${_LOAD_ORDER[@]}"; do
        # shellcheck disable=SC1090
        . "${_RC_D}/${_RC}"
    done
fi

unset _LOAD_ORDER _RC _RC_D

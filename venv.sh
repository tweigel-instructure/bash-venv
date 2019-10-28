#!/usr/bin/env bash

__python_main() {
    mkdir -p "${HOME}/.venv"
    complete -F __venv_autocomplete venv
    complete -F __venv_autocomplete venvrepair
    complete -o default -F __pip_autocomplete pip
}

venv() {  # switches into a .venv virtualenv
    local -r name="${1:-}"
    if __venv_valid "$name"; then
        echo "Switching to venv ${name}. To exit, type 'deactivate'."
        source "$(__venv_act $name)"
    else
        echo "Invalid venv name: ($name)"
    fi
}

venvls() {  # lists all of your .venv virtualenvs
    for dir in $(ls -1 -p "${HOME}/.venv/" | grep '/$' | tr -d '/'); do
        __venv_valid "$dir" && echo "$dir"
    done
}

venvmk() {  # creates a python3 .venv virtualenv
    mkdir -p "${HOME}/.venv/" >/dev/null 2>&1
    pushd "${HOME}/.venv/" >/dev/null 2>&1
        virtualenv --python python3 $@
    popd >/dev/null 2>&1
}

venvrepair() {
    local -r name="${1:-}"
    __venv_valid "$name" || echo "No virtualenv named: ($name)" && exit 0
    pushd "${HOME}/.venv/" >/dev/null 2>&1
        find "$(__venv_dir $name)" -type l -delete
        virtualenv --python python3 "$name"
    popd >/dev/null 2>&1
}

__venv_valid() {
    local -r name="${1:-}"
    [[ -f "$(__venv_act $name)" ]]
}

__venv_act() {
    local -r name="${1:-}"
    echo "$(__venv_dir $name)/bin/activate"
}

__venv_dir() {
    local -r name="${1:-}"
    echo "${HOME}/.venv/${name}"
}

__venv_autocomplete() {
    local partial=$2  # the portable and trustworthy value from bash `complete`
    local commands=($(venvls))

    local word=
    for word in "${commands[@]}"; do
        [[ "$word" =~ ^$partial ]] && COMPREPLY+=("$word")
    done
}

__pip_autocomplete() {
    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   PIP_AUTO_COMPLETE=1 $1 ) )
}

__python_main

# bash-venv
Some automation functions for Python3 virtualenv in bash. Primarily written in a MacOS environment, reasonably tested in a Linux environment.

Important caveats:

* This automation creates and uses a `~/.venv` directory automatically.
* This automation assumes Python3.
* This automation assumes you want `pip` to autocomplete and sets it up to do so.

## venvmk NAME

Creates a new virtualenv with NAME.

This always uses the system's Python3. On MacOS this will break if you have not installed python3. `venvmk` accepts the same options as `virtualenv` if you need to pass something else in.

## venvls

Gives a list of all virtualenv names created in `~/.venv` (which should mostly be those created with `venvmk` above).

## venv NAME

Activates the virtualenv named NAME. To deactivate, just type `deactivate` and hit enter. Assuming your system provides autocompletion, you can autocomplete the virtualenv names in your `~/.venv` directory.

## venvrepair NAME

With default virtualenv installations, upgrading the system Python3 can break the virtualenv, especially on MacOS. This will repair that breakage while retaining your existing package installations and any virtualenv-specific settings. Assuming your system provides autocompletion, you can autocomplete the virtualenv names in your `~/.venv` directory.

#! /usr/bin/env bash

source `which virtualenvwrapper.sh`

function make_neovim_env()
{
    python_exec=$1
    env_name=$2

    mkvirtualenv $env_name -p `which $python_exec`

    if [ $? -eq 0 ]
    then
        workon $env_name
        pip install --upgrade pip
        pip install neovim jedi
        deactivate
    else
        echo "$env_name already exists."
    fi
}

make_neovim_env "python" "neovim2"
make_neovim_env "python3" "neovim3"


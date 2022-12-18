#!/usr/bin/env bash

function cmd_exists() {
    local cmd=$1
    type "$cmd" > /dev/null ;
}

function ubuntu() {
    sudo apt update
    if ! cmd_exists just; then
        sudo apt install just
    fi
}

function mac() {
    if ! cmd_exists brew; then
        echo "Installing Homebrew"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo "Installed Homebrew"
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    if ! cmd_exists just; then
        echo "Installing just"
        brew install just
        echo "Installed just"
    fi
    just
}

if [ `uname` == "Darwin" ]; then
    mac
elif [ `grep DISTRIB_ID /etc/*-release | awk -F '=' '{print $2}'` == "Ubuntu" ]; then
    ubuntu
fi

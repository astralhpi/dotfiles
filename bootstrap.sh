#!/usr/bin/env bash

set -e

function cmd_exists() {
    local cmd=$1
    type "$cmd" > /dev/null ;
}

function install_nix_if_need() {
  option=$1
  if ! cmd_exists nix; then
    sh <(curl -L https://nixos.org/nix/install) $option
  fi
}

function ubuntu() {
    sudo apt update
    install_nix_if_need "--daemon"

    if ! cmd_exists just; then
        echo "Installing just"
        apt install just
        echo "Installed just"
    fi
}

function mac() {
    install_nix_if_need "--daemon"

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
}

if [ `uname` == "Darwin" ]; then
    mac
elif [ `grep DISTRIB_ID /etc/*-release | awk -F '=' '{print $2}'` == "Ubuntu" ]; then
    ubuntu
fi

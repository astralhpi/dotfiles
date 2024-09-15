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
    if [ -f /etc/bashrc ]; then
      . /etc/bashrc
    fi
    if [ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
      . "$HOME/.nix-profile/etc/profile.d/nix.sh"
    fi
    mkdir -p /nix/var/nix/profiles/per-user/$USER
  fi
}

function ubuntu() {
    install_nix_if_need "--no-daemon"

    if ! cmd_exists just; then
        echo "Installing just"
        nix-channel --update
        nix-env -iA nixpkgs.just
        nix-env -iA nixpkgs.zsh
        echo "Installed just"
    fi
}

function mac() {
    install_nix_if_need

    if ! cmd_exists brew; then
        echo "Installing Homebrew"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo "Installed Homebrew"
        (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> $HOME/.zprofile
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

#/bin/bash

function cmd_exists() {
    local cmd=$1
    type "$cmd" > /dev/null ;
}

if [ ! -e $HOME/.ssh/id_rsa.pub ]; then
    ssh-keygen -t rsa -b 4096 -C "jaehak@hpi.cc"
fi

if ! cmd_exists brew; then
    echo "Installing Homebrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    echo "Installed Homebrew"
fi

if ! cmd_exists mac; then
    echo "Installing mac-cli"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/guarinogabriel/mac-cli/master/mac-cli/tools/install)"
    echo "Installed mac-cli"
fi

cd packages
brew bundle -v


#/bin/bash

if [ ! -e $HOME/.ssh/id_rsa.pub ];
then
    ssh-keygen -t rsa -b 4096 -C "jaehak@hpi.cc"
fi

if ! type "brew" > /dev/null; then
    echo "Install Homebrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew tap Homebrew/bundle

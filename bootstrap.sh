#/bin/bash

if [ ! -e $HOME/.ssh/id_rsa.pub ];
then
    ssh-keygen -t rsa -b 4096 -C "jaehak@hpi.cc"
fi

# check OS
OS=$(lsb_release -si)

if [ OS='Ubuntu' ];
then
    add-apt-repository ppa:neovim-ppa/unstable
    apt-get update
    cat ./packages/apt-packages | xargs apt-get install
fi


#/bin/bash

ssh-keygen -t rsa -b 4096 -C "jaehak@hpi.cc"

# check OS
OS=$(lsb_release -si)

if [ OS='Ubuntu' ];
then
    cat ./packages/apt-packages | xargs apt-get install
fi


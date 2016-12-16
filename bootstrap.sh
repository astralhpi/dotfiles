#/bin/bash

BASEDIR=$( cd "$(dirname $0)" && pwd )

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

cd $BASEDIR/packages
brew bundle -v
cd $BASEDIR

if [ ! -f /Library/Fonts/SFMono-Regular.otf ]; then
    echo "Installing SFMono Fonts"
    cp /Applications/Xcode.app/Contents/SharedFrameworks/DVTKit.framework/Versions/A/Resources/Fonts/*.otf /Library/Fonts/
    echo "Installed SFMono Fonts"
fi

if [ ! -d $HOME/.zprezto ]; then
    $BASEDIR/scripts/install_prezto.zsh
fi


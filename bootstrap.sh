#/bin/bash

BASEDIR=$( cd "$(dirname $0)" && pwd )

function cmd_exists() {
    local cmd=$1
    type "$cmd" > /dev/null ;
}

function link() {
    TARGET=$HOME/$2
    if ! ([  -f $TARGET ] || [ -d $TARGET ]); then
        echo "link $1 to $2"
        ln -s "$BASEDIR/$1" "$HOME/$2"
    fi
}

if [ ! -e $HOME/.ssh/id_rsa.pub ]; then
    ssh-keygen -t rsa -b 4096 -C "jaehak@hpi.cc"
fi

if ! cmd_exists brew; then
    echo "Installing Homebrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    echo "Installed Homebrew"
fi

pip install -r $BASEDIR/packages/requirements_py2.txt
pip3 install -r $BASEDIR/packages/requirements_py3.txt

cd $BASEDIR/packages
brew bundle -v
cd $BASEDIR

if [ ! -f /Library/Fonts/SFMono-Regular.otf ]; then
    echo "Installing SFMono Fonts"
    cp /Applications/Xcode.app/Contents/SharedFrameworks/DVTKit.framework/Versions/A/Resources/Fonts/*.otf /Library/Fonts/
    echo "Installed SFMono Fonts"
fi

# zsh
link zsh/prezto .zprezto
link zsh/zlogin .zlogin
link zsh/zlogout .zlogout
link zsh/zpreztorc .zpreztorc
link zsh/zprofile .zprofile
link zsh/zshenv .zshenv
link zsh/zshrc_symlink .zshrc_symlink
link zsh/fzf.zsh .fzf.zsh
cp -n $BASEDIR/zsh/zshrc $HOME/.zshrc

# tmux
link tmux/tmux.conf .tmux.conf

# ctags
link config/ctags .ctags


# nvim
if [ ! -d $HOME/.config/nvim ]; then
    mkdir -p $HOME/.config
    link nvim .config/nvim
    pip install neovim
    pip3 install neovim
    nvim -c "PlugInstall" -c "UpdateRemotePlugins" -c "qa"
fi

# git
link config/gitconfig .gitconfig

# fzf
if [ ! -f ~/.fzf.zsh ]; then
    /usr/local/opt/fzf/install
fi

# karabiner-elements
mkdir -p $HOME/.karabiner.d/
link karabiner/configuration .karabiner.d/configuration

# hammerspoon
link hammerspoon .hammerspoon

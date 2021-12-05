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

function common_config() {
    # tpm
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

    

    # zsh
    link zsh/zprofile .zprofile
    link zsh/zshenv .zshenv
    link zsh/zshrc_symlink .zshrc_symlink
    cp -n $BASEDIR/zsh/zshrc $HOME/.zshrc

    # tmux
    link tmux/tmux.conf .tmux.conf

    # ctags
    link config/ctags .ctags

    # git
    link config/gitconfig .gitconfig


}
function ubuntu() {
    sudo add-apt-repository ppa:neovim-ppa/stable
    sudo add-apt-repository ppa:jonathonf/python-3.6
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

    sudo apt update
    cat $BASEDIR/packages/apt_requirements.txt | sudo xargs apt install -y

    pip install psutil thefuck

    # pip
    sudo pip install -r $BASEDIR/packages/requirements_py2.txt
    sudo pip3 install -r $BASEDIR/packages/requirements_py3.txt
    
    common_config
    chsh -s $(which zsh)

}

function mac() {
    if ! cmd_exists brew; then
        echo "Installing Homebrew"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo "Installed Homebrew"
    fi

    brew tap homebrew/cask-fonts
    cd $BASEDIR/packages
    brew bundle -v
    cd $BASEDIR

    if [ ! -f /Library/Fonts/SFMono-Regular.otf ]; then
        echo "Installing SFMono Fonts"
        cp /System/Applications/Utilities/Terminal.app/Contents/Resources/Fonts/*.otf /Library/Fonts/
        echo "Installed SFMono Fonts"
    fi
    
    # pip
    pip3 install -r $BASEDIR/packages/requirements_py3.txt
    
    common_config

    # fzf
    if [ ! -f ~/.fzf.zsh ]; then
        /usr/local/opt/fzf/install
    fi
    
    
    # nvim
    if [ ! -d $HOME/.config/nvim ]; then
        mkdir -p $HOME/.config
        link nvim .config/nvim
        pip2 install neovim
        pip3 install neovim
        gem install neovim
        nvim -c "PlugInstall" -c "UpdateRemotePlugins" -c "qa"
    fi

    # karabiner-elements
    mkdir -p $HOME/.config
    link karabiner .config/karabiner

    # hammerspoon
    link hammerspoon .hammerspoon

    link kitty .config/kitty
    link config/direnvrc .direnvrc

    chsh -s $(which zsh)
}

if [ `uname` == "Darwin" ]; then
    mac
elif [ `grep DISTRIB_ID /etc/*-release | awk -F '=' '{print $2}'` == "Ubuntu" ]; then
    ubuntu
fi

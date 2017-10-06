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

    # git
    link config/gitconfig .gitconfig


}
function ubuntu() {
    sudo add-apt-repository ppa:neovim-ppa/stable
    sudo apt update
    cat $BASEDIR/packages/apt_requirements.txt | sudo xargs apt install -y

    pip install psutil thefuck

    # pip
    sudo pip install -r $BASEDIR/packages/requirements_py2.txt
    sudo pip3 install -r $BASEDIR/packages/requirements_py3.txt
    
    common_config
    

    if [ ! -f ~/.fzf.zsh ]; then
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install
    fi

    # nvim
    if [ ! -d $HOME/.config/nvim ]; then
        mkdir -p $HOME/.config
        link nvim .config/nvim
        sudo pip install neovim
        sudo pip3 install neovim
        gem install neovim
        nvim -c "PlugInstall" -c "UpdateRemotePlugins" -c "qa"
    fi


    chsh -s $(which zsh)

}

function mac() {
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
    
    # pip
    pip2 install -r $BASEDIR/packages/requirements_py2.txt
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
    mkdir -p $HOME/.karabiner.d/
    link karabiner/configuration .karabiner.d/configuration

    # hammerspoon
    link hammerspoon .hammerspoon
}

if [ `uname` == "Darwin" ]; then
    mac
elif [ `grep DISTRIB_ID /etc/*-release | awk -F '=' '{print $2}'` == "Ubuntu" ]; then
    ubuntu
fi

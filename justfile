os := os()
home_dir := env_var('HOME')

default:
    just {{os}}

common: packages && font zsh tmux nvim git direnv starship chsh

packages-python:
    cd packages && pip3 install -r requirements.txt

zsh: (
    _link 'zsh/zprofile' home_dir / '.zprofile') (
    _link 'zsh/zshenv' home_dir / '.zshenv') (
    _link 'zsh/zshrc_symlink' home_dir / '.zshrc_symlink') (
    _cp 'zsh/zshrc' home_dir / '.zshrc')

tmux: (
    _link 'tmux/tmux.conf' home_dir / '.tmux.conf') (
    _clone 'https://github.com/tmux-plugins/tpm' home_dir / '.tmux/plugins/tpm') (
    _clone 'https://github.com/erikw/tmux-powerline' home_dir / '.tmux/plugins/tmux-powerline') (
    _link 'tmux/powerline/tmux-powerlinerc' home_dir / '.tmux-powerlinerc') (
    _link 'tmux/powerline' home_dir / '.tmux/powerline'
    )

git: (_link 'config/gitconfig' home_dir / '.gitconfig')

nvim: _config-dir && (_link 'nvim' home_dir / '.config/nvim')
    nvim -c "PlugInstall" -c "UpdateRemotePlugins" -c "qa"
    nvim -c "TSInstall vim python lua rust typescript javascript" -c "qa"

direnv: _config-dir && (_link 'config/direnvrc' home_dir / '.direnvrc')

starship: (_link 'config/starship.toml' home_dir / '.config/starship.toml')

chsh: (_run-if "[ -z `echo $SHELL | grep zsh` ]" "chsh -s `which zsh`")

secret command:
    just --justfile keybase.justfile {{command}}

# ===============================================================================
# macOS Only
# ===============================================================================

[macos]
macos: common karabiner hammerspoon nushell sudo-with-touchid keyboard

[macos]
packages: packages-brew packages-python

[macos]
packages-brew:
    cd packages && brew bundle -v

[macos]
karabiner: _config-dir && (_link 'karabiner' home_dir / '.config/karabiner')

[macos]
keyboard:
    defaults write -g InitialKeyRepeat -int 15
    defaults write -g KeyRepeat -int 1
    defaults write -g ApplePressAndHoldEnabled -bool false

[macos]
font:
    #!/usr/bin/env bash
    if [ ! -f /Library/Fonts/SF-Mono-Regular.otf ]; then
        echo "Installing SFMono Fonts"
        cp /System/Applications/Utilities/Terminal.app/Contents/Resources/Fonts/*.otf /Library/Fonts/
        echo "Installed SFMono Fonts"
    fi

[macos]
hammerspoon: (_link 'hammerspoon' home_dir / '.hammerspoon')

[macos]
nushell: (
    _dir home_dir / "'/Library/Application Support/nushell'") (
    _link 'nushell/env.nu' home_dir / "'/Library/Application Support/nushell/env.nu'") (
    _link 'nushell/config.nu' home_dir / "'/Library/Application Support/nushell/config.nu'")

[macos]
sudo-with-touchid: (_run-if 
        "! cat /etc/pam.d/sudo | grep pam_tid.so > /dev/null"
        "sudo sed -i '' '2s/^/auth       sufficient     pam_tid.so\\n/' /etc/pam.d/sudo"
    )


# ===============================================================================
# Polyglot Language Support
# ===============================================================================

polyglot: rust

rust: (_install-if-not-installed
        "rustup"
        "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
    )

node: (
    _install-if-not-installed
        "typescript-language-server"
        "npm install -g typescript-language-server typescript") (
    _install-if-not-installed
        "vscode-json-language-server"
        "npm install -g vscode-json-language-server"
    )

# ===============================================================================
# Common Private Recipes
# ===============================================================================

_config-dir: (_dir home_dir / '.config')

_dir path: (_run-if
    "[ ! -d "+ path + " ]"
    "mkdir -p " + path)

_clone repo dst: (_run-if-not-exists "git clone" repo dst)
_cp src dst: (_run-if-not-exists "cp -n" src dst)
_link src dst: (_run-if-not-exists "ln -s" justfile_directory() / src dst)

_run-if-not-exists cmd src dst: (_run-if
    "! ([ -f " + dst + " ] || [ -d " + dst + " ])"
    cmd + " " + src + " " + dst )

_install-if-not-installed cmd install_cmd: (_run-if "[ -z `command -v " + cmd +"` ]" install_cmd)

_run-if cond body:
    #!/usr/bin/env bash
    if {{cond}}; then
        echo "run: {{body}}"
        {{body}}
    fi
